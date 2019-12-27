module Eth_10g_receive_from_10gmac(
	input  					clk_156_25,								//PHY和MAC的时钟156.25MHz
	input					rst_n,									//复位信号
	input					avalon_st_rx_startofpacket,				//数据流开头
	input					avalon_st_rx_endofpacket,				//数据流结尾
	input					avalon_st_rx_valid,						//数据流信号有效
	output reg				avalon_st_rx_ready,						//用户已准备好接收数据
	input		[63:0]		avalon_st_rx_data,						//数据流
	input		[2:0]		avalon_st_rx_empty,						//数据流结尾未使用的字符
	input		[5:0]		avalon_st_rx_error,						//接收错误类型信号
	
	output reg	[47:0]		mac_dst_addr,							//目的地址
	input		[47:0]		mac_src_addr,							//源地址
	output reg	[15:0]		mac_type,								//类型字段
	input		[31:0]		ip_src_addr,							//源IP地址
	input		[31:0]		ip_dst_addr,							//目的IP地址
	output reg				arp_op,									//当接收到一次ARP请求时，产生一个脉冲
	
	output		[63:0] 		wr_data,								//写入fifo的数据
	output reg				wr_req,                             	//fifo写请求
	
	output reg				rx_receive								//当完成一次数据的接收时，产生一个脉冲
);

parameter idle 			= 8'h01;									//空闲状态
parameter rx_mac 		= 8'h02;									//解析MAC帧头
parameter rx_udp 		= 8'h04;									//接收IP数据报头部、UDP数据报头部
parameter rx_arp_req 	= 8'h08;									//ARP请求
parameter rx_arp_ans 	= 8'h10;									//ARP应答
parameter rx_arp 		= 8'h20;									//ARP
parameter rx_data		= 8'h40;									//接收数据
parameter rx_wait 		= 8'h80;

parameter arp_ans 		= 16'h0002;									//操作码(0002为ARP应答)
parameter arp_req 		= 16'h0001; 								//操作码(0001为ARP请求)
parameter mac_type_ip 	= 16'h0800;									//类型字段（0800为IP数据报）
parameter mac_type_arp 	= 16'h0806;									//类型字段（0806为ARP帧）

//指示用户已准备好接收数据
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		avalon_st_rx_ready <= 1'b0;
	end
	else begin
		avalon_st_rx_ready <= 1'b1;
	end
end

//数据缓存一级
reg[63:0]r_data;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		r_data <= 64'b0;
	end
	else begin
		r_data <= avalon_st_rx_data;
	end
end

reg[7:0]state;														//状态机
reg[1:0]i;															//变量
reg[15:0]r_mac_src_addr;											//源mac地址最高16位缓存
reg r_arp_op;														//指示收到arp请求

assign wr_data = r_data;

always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		state <= idle;
		i<=2'd0;
		rx_receive <= 1'b0;
		wr_req <= 1'b0;
		arp_op <= 1'b0;
		r_arp_op <= 1'b0;
		mac_type <= 16'b0;
		mac_dst_addr <= 48'hff_ff_ff_ff_ff_ff;
	end
	else if(avalon_st_rx_valid)begin
		case(state)
			idle:begin
				rx_receive <= 1'b0;
				wr_req <= 1'b0;
				arp_op <= 1'b0;
				r_arp_op <= 1'b0;
				i <= 2'd0;
				if(avalon_st_rx_startofpacket)begin
					state <= rx_mac;
				end
				else begin
					state <= idle;
				end
			end
			
			rx_mac:begin
				case(i)
					2'd0:begin
						if(r_data[63:16] == mac_src_addr)begin						//检验目的mac地址是否为本机mac地址
							state <= state;
							i <= 2'd1;
						end
						else if(r_data[63:16] == 48'hff_ff_ff_ff_ff_ff)begin		//检验目的mac地址是否为广播地址
							state <= state;
							i <= 2'd2;
						end
						else begin
							state <= idle;
							i <= 2'd0;
						end
					end
					2'd1:begin														//若目的mac地址为本机mac地址，则应为udp数据报或arp应答，其余非法
						mac_type <= r_data[31:16];
						i <= 2'd0;
						if(r_data[31:16] == mac_type_ip)begin						//检验上层协议是否为ip协议
							state <= rx_udp;
						end
						else if(r_data[31:16] == mac_type_arp)begin					//检验上层协议是否为arp协议(向本机发送的arp协议必须为arp应答)
							state <= rx_arp_ans;
						end
						else begin
							state <= idle;
						end
					end
					2'd2:begin														//若目的mac地址为广播地址，则应为arp请求，其余非法
						mac_type <= r_data[31:16];
						i <= 2'd0;
						if(r_data[31:16] == mac_type_arp)begin						//检验上层协议是否为arp协议(广播方式发送的arp协议必须为arp请求)
							state <= rx_arp_req;
						end
						else begin
							state <= idle;
						end
					end
					default:begin
						state <= idle;
						i <= 2'd0;
					end
				endcase
			end
			
			rx_arp_req:begin														//若上层协议为arp请求，则准备发送arp应答
				r_mac_src_addr <= r_data[15:0];
				if(r_data[31:16] == arp_req)begin
					r_arp_op <= 1'b1;
					state <= rx_arp;
				end
				else begin
					r_arp_op <= 1'b0;
					state <= idle;
				end
			end
			
			rx_arp_ans:begin
				r_mac_src_addr <= r_data[15:0];
				r_arp_op <= 1'b0;
				if(r_data[31:16] == arp_ans)begin
					state <= rx_arp;
				end
				else begin
					state <= idle;
				end
			end
			
			rx_arp:begin																			//无论上层协议为arp请求还是arp应答均修改目的mac地址
				if((r_data[31:0] == ip_dst_addr) && (avalon_st_rx_error == 6'b0))begin				//检验源ip地址是否为指定接收的ip地址并查看CRC校验情况
					mac_dst_addr <= {r_mac_src_addr, r_data[63:32]};
					state <= rx_wait;
				end
				else begin
					r_arp_op <= 1'b0;
					state <= idle;
				end
			end
			
			rx_wait:begin																			//arp协议处理完毕，继续接收无效字节，等待结束。
				if(avalon_st_rx_endofpacket)begin
					rx_receive <= 1'b1;
					state <= idle;
					if(r_arp_op)begin
						arp_op <= 1'b1;
					end
				end
				else begin
					rx_receive <= 1'b0;
					arp_op <= 1'b0;
					state <= state;
				end
			end
			
			rx_udp:begin																			//接收数据头部
				case(i)
					2'd0:begin
						i <= i + 1'b1;
					end
					2'd1:begin
						if((r_data[47:16] == ip_dst_addr) && (avalon_st_rx_error == 6'b0))begin		//检验源ip地址是否为指定接收的ip地址并查看CRC校验情况
							i <= i + 1'b1;
						end
						else begin
							i <= 2'b0;
							state <= idle;
						end
					end
					2'd2:begin
						state <= rx_data;
						i <= 2'b0;
					end
					default:begin
						state <= idle;
						i <= 2'b0;
					end
				endcase
			end
			
			rx_data:begin																			//接收数据
				wr_req <= 1'b1;
				if(avalon_st_rx_endofpacket)begin
					rx_receive <= 1'b1;
					state <= idle;
				end
				else begin
					rx_receive <= 1'b0;
					state <= state;
				end
			end
			
			default:begin
				rx_receive <= 1'b0;
				wr_req <= 1'b0;
				arp_op <= 1'b0;
				state <= idle;
				r_arp_op <= 1'b0;
				i <= 2'd0;
			end
		endcase
	end
	else begin
		rx_receive <= 1'b0;
		wr_req <= 1'b0;
		arp_op <= 1'b0;
	end
end


endmodule
