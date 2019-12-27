module Eth_10g_send_to_10gmac(
	input  				clk_156_25,									//PHY和MAC的时钟156.25MHz
	input				rst_n,										//复位信号
	output 	 			avalon_st_tx_startofpacket,					//数据流开头
	output 	 			avalon_st_tx_valid,							//数据流信号有效
	input  				avalon_st_tx_ready,							//MAC已准备好接收数据
	output 	 			avalon_st_tx_endofpacket,					//数据流结尾
	output 		[2:0]	avalon_st_tx_empty,							//数据流结尾未使用的字符
	output 		[63:0]	avalon_st_tx_data,							//数据流
	output 				avalon_st_tx_error,							//发送错误信号
	output 		[1:0] 	avalon_st_pause_data,						//发送停止信号
	
	input		[47:0]	mac_dst_addr,								//目的地址
	input		[47:0]	mac_src_addr,								//源地址
	input		[15:0]	mac_type,									//类型字段（0806为ARP帧、0800为UDP）
	input				arp_op,										//ARP操作类型(1为应答、0为请求)

	input		[31:0]	ip_src_addr,								//源IP地址
	input		[31:0]	ip_dst_addr,								//目的IP地址

	input				tx_start,									//用户指示开始发送数据包（发送数据时，需要持续拉高直至tx_idle被拉低）
	output 				tx_idle,									//用以指示用户是否正处于空闲状态
	
	input		[15:0]	data_length,								//待发送数据长度
	output				rd_req,										//fifo读请求
	input		[63:0]	rd_data										//fifo读出的数据
);

parameter mac_type_ip 	= 16'h0800;									//类型字段（0800为IP数据报）
parameter mac_type_arp 	= 16'h0806;									//类型字段（0806为ARP帧）

reg r_tx_start;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		r_tx_start <= 1'b0;
	end
	else begin
		r_tx_start <= tx_start;
	end
end

wire tx_start_pos;
assign tx_start_pos = (~r_tx_start) & tx_start;

reg[47:0] r_mac_dst_addr;
reg[47:0] r_mac_src_addr;
reg[31:0] r_ip_src_addr;
reg[31:0] r_ip_dst_addr;
reg[15:0] r_data_length;
reg[15:0] r_mac_type;
reg r_arp_op;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		r_mac_dst_addr <= 48'b0;
	   r_mac_src_addr <= 48'b0;
	   r_ip_src_addr <= 32'b0;
	   r_ip_dst_addr <= 32'b0;
	   r_data_length <= 16'b0;
		r_mac_type <= 16'b0;
		r_arp_op <= 1'b0;
	end
	else if(tx_start_pos)begin
		r_mac_dst_addr <= mac_dst_addr;
	   r_mac_src_addr <= mac_src_addr;
	   r_ip_src_addr <= ip_src_addr;
	   r_ip_dst_addr <= ip_dst_addr;
	   r_data_length <= data_length;
		r_mac_type <= mac_type;
		r_arp_op <= arp_op;
	end
end

wire 		udp_avalon_st_tx_startofpacket;
wire 		udp_avalon_st_tx_valid;
wire 		udp_avalon_st_tx_endofpacket;
wire[2:0] 	udp_avalon_st_tx_empty;
wire[63:0] 	udp_avalon_st_tx_data;
wire 		udp_avalon_st_tx_error;
wire[1:0] 	udp_avalon_st_pause_data;

wire udp_tx_start;
wire udp_tx_idle;
assign udp_tx_start = r_tx_start & (r_mac_type == mac_type_ip);
udp_send_to_10gmac udp_send_to_10gmac_inst
(
	.clk_156_25(clk_156_25),													//	input  					//PHY和MAC的时钟156.25MHz
	.rst_n(rst_n),																// 	input					//复位信号
	.avalon_st_tx_startofpacket(udp_avalon_st_tx_startofpacket),				//	output 	 				//数据流开头
	.avalon_st_tx_valid(udp_avalon_st_tx_valid),								//	output 	 				//数据流信号有效
	.avalon_st_tx_ready(avalon_st_tx_ready),									//	input  					//MAC已准备好接收数据
	.avalon_st_tx_endofpacket(udp_avalon_st_tx_endofpacket),					//	output 	 				//数据流结尾
	.avalon_st_tx_empty(udp_avalon_st_tx_empty),								//	output 		[2:0]		//数据流结尾未使用的字符
	.avalon_st_tx_data(udp_avalon_st_tx_data),									//	output 		[63:0]		//数据流
	.avalon_st_tx_error(udp_avalon_st_tx_error),								//	output 					//发送错误信号
	.avalon_st_pause_data(udp_avalon_st_pause_data),             				// 	output 		[1:0]    	//发送停止信号

	.mac_dst_addr(r_mac_dst_addr),												//	input		[47:0]		//目的地址
	.mac_src_addr(r_mac_src_addr),                            					// 	input		[47:0]		//源地址
	.mac_type(r_mac_type),                                 						// 	input		[15:0]		//类型字段（0800为IP数据报）

	.ip_src_addr(r_ip_src_addr),												// 	input		[31:0]		//192.168.0.2	源IP地址
	.ip_dst_addr(r_ip_dst_addr),                              					// 	input		[31:0]		//192.168.0.3	目的IP地址

	.tx_start(udp_tx_start),													//	input					//用户指示开始发送UDP数据包
	.tx_idle(udp_tx_idle),														//	output 					//用以指示用户是否正处于空闲状态

	.data_length(r_data_length),												//	input		[15:0]		//待发送数据长度
	.rd_req(rd_req),															// 	output					//fifo读请求
	.rd_data(rd_data)															// 	input		[63:0]		//fifo读出的数据

);

wire 			arp_avalon_st_tx_startofpacket;
wire 			arp_avalon_st_tx_valid;
wire 			arp_avalon_st_tx_endofpacket;
wire[2:0] 		arp_avalon_st_tx_empty;
wire[63:0] 		arp_avalon_st_tx_data;
wire 			arp_avalon_st_tx_error;
wire[1:0] 		arp_avalon_st_pause_data;

wire arp_tx_start;
wire arp_tx_idle;
assign arp_tx_start = r_tx_start & (r_mac_type == mac_type_arp);
arp_send_to_10gmac arp_send_to_10gmac_inst(
	.clk_156_25(clk_156_25),													//	input  					//PHY和MAC的时钟156.25MHz
	.rst_n(rst_n),																// 	input					//复位信号
	.avalon_st_tx_startofpacket(arp_avalon_st_tx_startofpacket),				//	output 	 				//数据流开头
	.avalon_st_tx_valid(arp_avalon_st_tx_valid),								//	output 	 				//数据流信号有效
	.avalon_st_tx_ready(avalon_st_tx_ready),									//	input  					//MAC已准备好接收数据
	.avalon_st_tx_endofpacket(arp_avalon_st_tx_endofpacket),					//	output 	 				//数据流结尾
	.avalon_st_tx_empty(arp_avalon_st_tx_empty),								//	output 		[2:0]		//数据流结尾未使用的字符
	.avalon_st_tx_data(arp_avalon_st_tx_data),									//	output 		[63:0]		//数据流
	.avalon_st_tx_error(arp_avalon_st_tx_error),								//	output 					//发送错误信号
	.avalon_st_pause_data(arp_avalon_st_pause_data),             				// 	output 		[1:0]    	//发送停止信号

	.mac_dst_addr(r_mac_dst_addr),												//	input		[47:0]		//目的地址
	.mac_src_addr(r_mac_src_addr),                           					// 	input		[47:0]		//源地址
	.mac_type(r_mac_type),                                						// 	input		[15:0]		//类型字段（0806为ARP帧）
	.arp_op(r_arp_op),				
	.ip_src_addr(r_ip_src_addr),												// 	input		[31:0]		//192.168.0.2	源IP地址
	.ip_dst_addr(r_ip_dst_addr),                             					// 	input		[31:0]		//192.168.0.3	目的IP地址
	
	.tx_start(arp_tx_start),													//	input					//用户指示开始发送ARP数据包
	.tx_idle(arp_tx_idle)														//	output 					//用以指示用户是否正处于空闲状态
);

assign avalon_st_tx_startofpacket	= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_startofpacket	: udp_avalon_st_tx_startofpacket;
assign avalon_st_tx_valid			= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_valid			: udp_avalon_st_tx_valid;
assign avalon_st_tx_endofpacket		= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_endofpacket	: udp_avalon_st_tx_endofpacket;
assign avalon_st_tx_empty			= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_empty			: udp_avalon_st_tx_empty;
assign avalon_st_tx_data			= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_data			: udp_avalon_st_tx_data;
assign avalon_st_tx_error			= (r_mac_type == mac_type_arp) ? arp_avalon_st_tx_error			: udp_avalon_st_tx_error;
assign avalon_st_pause_data			= (r_mac_type == mac_type_arp) ? arp_avalon_st_pause_data		: udp_avalon_st_pause_data;

assign tx_idle = arp_tx_idle & udp_tx_idle & avalon_st_tx_ready;

endmodule

