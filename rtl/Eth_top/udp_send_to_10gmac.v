module udp_send_to_10gmac(

	//时钟及复位信号
	input  				clk_156_25,									//PHY和MAC的时钟156.25MHz
	input				rst_n,										//复位信号
	
	//avalon-st总线信号
	output reg 			avalon_st_tx_startofpacket,					//数据流开头
	output reg 			avalon_st_tx_valid,							//数据流信号有效
	input  				avalon_st_tx_ready,							//MAC已准备好接收数据
	output reg 			avalon_st_tx_endofpacket,					//数据流结尾
	output reg	[2:0]	avalon_st_tx_empty,							//数据流结尾未使用的字符
	output reg	[63:0]	avalon_st_tx_data,							//数据流
	output 				avalon_st_tx_error,							//发送错误信号
	output 		[1:0] 	avalon_st_pause_data,						//发送停止信号

	//以太网字段信息
	input		[47:0]	mac_dst_addr,								//目的地址
	input		[47:0]	mac_src_addr,								//源地址
	input		[15:0]	mac_type,									//类型字段（0800为IP数据报）
	input		[31:0]	ip_src_addr,								//源IP地址
	input		[31:0]	ip_dst_addr,								//目的IP地址

	//用户端口信号
	input				tx_start,									//用户指示开始发送UDP数据包
	output reg			tx_idle,									//用以指示用户是否正处于空闲状态
	input		[15:0]	data_length,								//待发送数据长度

	//发送机fifo端口信号
	output				rd_req,										//fifo读请求
	input		[63:0]	rd_data										//fifo读出的数据
);

parameter idle		= 4'h1;											//空闲状态
parameter ready		= 4'h2;											//准备IP数据报报头和UDP数据报报头
parameter send_head	= 4'h4;											//发送MAC帧、IP数据报、UDP数据报
parameter send_data	= 4'h8;											//发送数据

reg[3:0]	tx_state;												//UDP数据发送状态机
reg 		rd_req_en;												//fifo可读使能
reg[15:0] 	ip_total_length;										//发送IP包的总长度
reg[15:0] 	udp_total_length;										//发送UDP包的总长度
reg[7:0]	mac_frame[13:0];										//MAC帧头（目的地址+源地址+类型字段）
reg[31:0] 	ip_header [4:0];										//IP数据报首部
reg[31:0] 	udp_header[1:0];										//UDP数据报首部
reg[31:0] 	ip_check;												//IP校验和计算
reg[15:0] 	tx_data_counter;										//待发送数据减计数器
reg[2:0]	i;

assign rd_req = rd_req_en & avalon_st_tx_ready;						//fifo可读，MAC可发时，请求读fifo
assign avalon_st_tx_error = 1'b0;									//不停止
assign avalon_st_pause_data = 2'b0;									//不暂停

//数据发送状态机
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		i <= 3'b0;
		tx_data_counter <= 16'b0;
		rd_req_en <= 1'b0;
		avalon_st_tx_startofpacket <= 1'b0;
		avalon_st_tx_empty <= 3'b0;
		avalon_st_tx_data <= 64'b0;
		avalon_st_tx_endofpacket <= 1'b0;
		avalon_st_tx_valid <= 1'b0;
		tx_idle <= 1'b1;
		tx_state <= idle;
	end
	else if(avalon_st_tx_ready)begin
		case(tx_state)
			idle:begin
				i <= 3'b0;
				tx_data_counter <= 16'b0;
				rd_req_en <= 1'b0;
				avalon_st_tx_startofpacket <= 1'b0;
				avalon_st_tx_empty <= 3'b0;
				avalon_st_tx_data <= 64'b0;
				avalon_st_tx_endofpacket <= 1'b0;
				avalon_st_tx_valid <= 1'b0;
				if(tx_start)begin
					tx_state <= ready;
					tx_idle <= 1'b0;
					{mac_frame[0], mac_frame[1], mac_frame[2], mac_frame[3], mac_frame[4], mac_frame[5]} <= mac_dst_addr;
					{mac_frame[6], mac_frame[7], mac_frame[8], mac_frame[9], mac_frame[10], mac_frame[11]} <= mac_src_addr;
					{mac_frame[12], mac_frame[13]} <= mac_type;
					tx_data_counter <= data_length;
					udp_total_length <= data_length + 16'd14;//16'd8 + 16'd6;					//UDP数据报总长度+6个字节的0(方便书写代码)
					ip_total_length <= data_length + 16'd34;//udp_total_length + 16'd20;		//IP数据报总长度
				end
				else begin
					tx_state <= idle;
					tx_idle <= 1'b1;
				end
			end
			ready:begin
				case(i)
					3'd0:begin
						ip_header[0] <={16'h4500, ip_total_length};					//版本号:4+首部长度:20+服务类型+IP数据报的总长度
						ip_header[1][31:16] <= ip_header[1][31:16] + 1'b1;   		//标识
						ip_header[1][15:0]<=16'h4000;								//标志（DF=1+MF=0）+片偏移（13位）
						ip_header[2] <= 32'h80110000;								//生存时间为0x80次转发+协议：0x11(UDP:17)+首部校验和先置零
						ip_header[3] <= ip_src_addr;								//源IP地址
						ip_header[4] <= ip_dst_addr;								//目的IP地址
						
						udp_header[0] <= 32'h1f901f90;								//2个字节的源端口号和2个字节的目的端口号
						udp_header[1] <= {udp_total_length, 16'h0000};				//2个字节的数据长度和2个字节的校验和（无）

						i <= i + 1'b1;
					end
					3'd1:begin
						ip_check <= ((ip_header[0][15:0] + ip_header[0][31:16]) +
										(ip_header[1][15:0] + ip_header[1][31:16])) +
										((ip_header[2][15:0] + ip_header[2][31:16]) +
										(ip_header[3][15:0] + ip_header[3][31:16])) +
										(ip_header[4][15:0] + ip_header[4][31:16]);
										
						i <= i + 1'b1;
					end
					3'd2:begin
						if(ip_check[31:16])begin
							ip_check <= ip_check[31:16] + ip_check[15:0];
						end
						else begin
							ip_header[2][15:0] <= ~ip_check[15:0];							//IP数据报首部校验和
							
							tx_state <= send_head;
							
							i <= 3'b0;
						end
					end
					default : i <= 3'b0;
				endcase
			end
			send_head:begin
				
				case(i)
					3'd0:begin
						avalon_st_tx_startofpacket <= 1'b1;
						avalon_st_tx_valid <= 1'b1;
						avalon_st_tx_data <= {
													mac_frame[0], mac_frame[1], mac_frame[2], mac_frame[3],
													mac_frame[4], mac_frame[5], mac_frame[6], mac_frame[7]
													};
						i <= i + 1'b1;
					end
					
					3'd1:begin
						avalon_st_tx_startofpacket <= 1'b0;
						avalon_st_tx_data <= {
													mac_frame[8], mac_frame[9], mac_frame[10], mac_frame[11],
													mac_frame[12], mac_frame[13], ip_header[0][31:24], ip_header[0][23:16]
													};
						i <= i + 1'b1;
					end
					
					3'd2:begin
						avalon_st_tx_data <= {
													ip_header[0][15:8], ip_header[0][7:0], ip_header[1][31:24], ip_header[1][23:16],
													ip_header[1][15:8], ip_header[1][7:0], ip_header[2][31:24], ip_header[2][23:16]
													};
						i <= i + 1'b1;
					end
					
					3'd3:begin
						avalon_st_tx_data <= {
													ip_header[2][15:8], ip_header[2][7:0], ip_header[3][31:24], ip_header[3][23:16],
													ip_header[3][15:8], ip_header[3][7:0], ip_header[4][31:24], ip_header[4][23:16]
													};
						i <= i + 1'b1;
					end
					
					3'd4:begin
						avalon_st_tx_data <= {
													ip_header[4][15:8], ip_header[4][7:0], udp_header[0][31:24], udp_header[0][23:16],
													udp_header[0][15:8], udp_header[0][7:0], udp_header[1][31:24], udp_header[1][23:16]
													};
						i <= i + 1'b1;
						rd_req_en <= 1'b1;						//提前准备fifo数据
					end
					
					
					3'd5:begin
						avalon_st_tx_data <= {
													udp_header[1][15:8], udp_header[1][7:0], 8'h00, 8'h00, 8'h00, 8'h00, 8'h00, 8'h00
													};						//数据中插入6个字节的0(方便书写代码)
						i <= 3'd0;
						tx_state <= send_data;
					end
					default : i <= 3'b0;
				endcase
			end
			send_data:begin
				if(tx_data_counter > 16'd16)begin
					avalon_st_tx_data <= rd_data;
					tx_data_counter <= tx_data_counter - 16'd8;
				end
				else if(tx_data_counter > 16'd8)begin
					rd_req_en <= 1'b0;							//提前关闭fifo数据
					avalon_st_tx_data <= rd_data;
					tx_data_counter <= tx_data_counter - 16'd8;
				end
				else begin
					avalon_st_tx_endofpacket <= 1'b1;
					avalon_st_tx_data <= rd_data;
					avalon_st_tx_empty <= 16'd8 - tx_data_counter;
					tx_state <= idle;
					tx_idle <= 1'b1;
				end

			end
			default:begin
				tx_state <= idle;
				tx_idle <= 1'b1;
			end
		endcase
	end
end

endmodule
