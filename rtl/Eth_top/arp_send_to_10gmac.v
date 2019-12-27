module arp_send_to_10gmac(

	//时钟及复位信号
	input  					clk_156_25,									//PHY和MAC的时钟156.25MHz
	input					rst_n,										//复位信号
	
	//avalon-st总线信号
	output reg 				avalon_st_tx_startofpacket,					//数据流开头
	output reg 				avalon_st_tx_valid,							//数据流信号有效
	input  					avalon_st_tx_ready,							//MAC已准备好接收数据
	output reg 				avalon_st_tx_endofpacket,					//数据流结尾
	output reg	[2:0]		avalon_st_tx_empty,							//数据流结尾未使用的字符
	output reg	[63:0]		avalon_st_tx_data,							//数据流
	output 					avalon_st_tx_error,							//发送错误信号
	output 		[1:0] 		avalon_st_pause_data,						//发送停止信号
	
	//以太网字段信息
	input		[47:0]		mac_dst_addr,								//目的地址
	input		[47:0]		mac_src_addr,								//源地址
	input		[15:0]		mac_type,									//类型字段（0806为ARP帧）
	input		[31:0]		ip_src_addr,								//源IP地址
	input		[31:0]		ip_dst_addr,								//目的IP地址
	input					arp_op,										//ARP操作类型(1为应答、0为请求)
	
	//用户端口信号
	input					tx_start,									//用户指示开始发送ARP数据包
	output reg				tx_idle										//用以指示用户是否正处于空闲状态
);

parameter mac_boardcast_addr	= 48'hff_ff_ff_ff_ff_ff; 				//广播地址
parameter arp_hard_type 		= 16'h0001; 							//硬件类型(0001为以太网类型)
parameter protocl				= 16'h0800; 							//上层协议(0800为IP协议)
parameter mac_length			= 8'h06;								//MAC地址长度（6字节）
parameter ip_length				= 8'h04;								//IP地址长度（4字节）
parameter op_req				= 16'h0001; 							//操作码(0001为ARP请求)
parameter op_ans				= 16'h0002; 							//操作码(0002为ARP应答)

reg[3:0] tx_state;														//ARP发送状态机
reg[7:0] arp_frame[41:0];												//ARP帧

always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		avalon_st_tx_startofpacket <= 1'b0;
		avalon_st_tx_empty <= 3'b0;
		avalon_st_tx_data <= 64'b0;
		avalon_st_tx_endofpacket <= 1'b0;
		avalon_st_tx_valid <= 1'b0;
		tx_idle <= 1'b1;
		tx_state <= 4'b0;
	end
	else if(avalon_st_tx_ready)begin
		case(tx_state)
			4'd0:begin
				avalon_st_tx_startofpacket <= 1'b0;
				avalon_st_tx_empty <= 3'b0;
				avalon_st_tx_data <= 64'b0;
				avalon_st_tx_endofpacket <= 1'b0;
				avalon_st_tx_valid <= 1'b0;
				if(tx_start)begin
					tx_state <= tx_state + 1'b1;
					tx_idle <= 1'b0;
					
					if(arp_op)begin
						{arp_frame[0], arp_frame[1], arp_frame[2], arp_frame[3], arp_frame[4], arp_frame[5]} 		<= mac_dst_addr;
						{arp_frame[6], arp_frame[7], arp_frame[8], arp_frame[9], arp_frame[10], arp_frame[11]} 		<= mac_src_addr;
						{arp_frame[12], arp_frame[13]} 																<= mac_type;
						{arp_frame[14], arp_frame[15]} 																<= arp_hard_type;
						{arp_frame[16], arp_frame[17]} 																<= protocl;
						{arp_frame[18]} 																			<= mac_length;
						{arp_frame[19]} 																			<= ip_length;
						{arp_frame[20], arp_frame[21]} 																<= op_ans;
						{arp_frame[22], arp_frame[23], arp_frame[24], arp_frame[25], arp_frame[26], arp_frame[27]} 	<= mac_src_addr;
						{arp_frame[28], arp_frame[29], arp_frame[30], arp_frame[31]} 								<= ip_src_addr;
						{arp_frame[32], arp_frame[33], arp_frame[34], arp_frame[35], arp_frame[36], arp_frame[37]} 	<= mac_dst_addr;
						{arp_frame[38], arp_frame[39], arp_frame[40], arp_frame[41]} 								<= ip_dst_addr;
					end
					else begin
						{arp_frame[0], arp_frame[1], arp_frame[2], arp_frame[3], arp_frame[4], arp_frame[5]} 		<= mac_boardcast_addr;
						{arp_frame[6], arp_frame[7], arp_frame[8], arp_frame[9], arp_frame[10], arp_frame[11]} 		<= mac_src_addr;
						{arp_frame[12], arp_frame[13]} 																<= mac_type;
						{arp_frame[14], arp_frame[15]} 																<= arp_hard_type;
						{arp_frame[16], arp_frame[17]} 																<= protocl;
						{arp_frame[18]} 																			<= mac_length;
						{arp_frame[19]} 																			<= ip_length;
						{arp_frame[20], arp_frame[21]} 																<= op_req;
						{arp_frame[22], arp_frame[23], arp_frame[24], arp_frame[25], arp_frame[26], arp_frame[27]} 	<= mac_src_addr;
						{arp_frame[28], arp_frame[29], arp_frame[30], arp_frame[31]} 								<= ip_src_addr;
						{arp_frame[32], arp_frame[33], arp_frame[34], arp_frame[35], arp_frame[36], arp_frame[37]} 	<= mac_boardcast_addr;
						{arp_frame[38], arp_frame[39], arp_frame[40], arp_frame[41]} 								<= ip_dst_addr;
					end
				end
				else begin
					tx_state <= 4'd0;
					tx_idle <= 1'b1;
				end
			end
			4'd1:begin
				avalon_st_tx_startofpacket <= 1'b1;
				avalon_st_tx_valid <= 1'b1;
				avalon_st_tx_data <= {
											arp_frame[0], arp_frame[1], arp_frame[2], arp_frame[3],
											arp_frame[4], arp_frame[5], arp_frame[6], arp_frame[7]
											};
				tx_state <= tx_state + 1'b1;
			end	
			4'd2:begin
				avalon_st_tx_data <= {
											arp_frame[8], arp_frame[9], arp_frame[10], arp_frame[11],
											arp_frame[12], arp_frame[13], arp_frame[14], arp_frame[15]
											};
				tx_state <= tx_state + 1'b1;
			end
			4'd3:begin
				avalon_st_tx_data <= {
											arp_frame[16], arp_frame[17], arp_frame[18], arp_frame[19],
											arp_frame[20], arp_frame[21], arp_frame[22], arp_frame[23]
											};
				tx_state <= tx_state + 1'b1;
			end
			4'd4:begin
				avalon_st_tx_data <= {
											arp_frame[24], arp_frame[25], arp_frame[26], arp_frame[27],
											arp_frame[28], arp_frame[29], arp_frame[30], arp_frame[31]
											};
				tx_state <= tx_state + 1'b1;
			end
			4'd5:begin
				avalon_st_tx_data <= {
											arp_frame[32], arp_frame[33], arp_frame[34], arp_frame[35],
											arp_frame[36], arp_frame[37], arp_frame[38], arp_frame[39]
											};
				tx_state <= tx_state + 1'b1;
			end
			4'd6:begin
				avalon_st_tx_data <= {arp_frame[40], arp_frame[41], 48'hff_ff_ff_ff_ff_ff};
				tx_state <= tx_state + 1'b1;
			end
			4'd7:begin
				avalon_st_tx_data <= 64'hff_ff_ff_ff_ff_ff_ff_ff;
				tx_state <= tx_state + 1'b1;
			end
			4'd8:begin
				avalon_st_tx_data <= 64'hff_ff_ff_ff_ff_ff_ff_ff;
				avalon_st_tx_endofpacket <= 1'b1;
				avalon_st_tx_empty <= 3'd4;
				tx_state <= 4'd0;
			end
			default:begin
				tx_state <= 4'd0;
			end
		endcase
	end
end

assign avalon_st_tx_error = 1'b0;									//不报错
assign avalon_st_pause_data = 2'b0;									//不暂停


endmodule
