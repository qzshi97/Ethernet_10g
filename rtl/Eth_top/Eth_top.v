module Eth_top(
	input  					clk_156_25,								//PHY和MAC的时钟156.25MHz
	input					rst_n,									//复位信号
	
	output 	 				avalon_st_tx_startofpacket,				//数据流开头
	output 	 				avalon_st_tx_valid,						//数据流信号有效
	input  					avalon_st_tx_ready,						//MAC已准备好接收数据
	output 	 				avalon_st_tx_endofpacket,				//数据流结尾
	output 		[2:0]		avalon_st_tx_empty,						//数据流结尾未使用的字符
	output 		[63:0]		avalon_st_tx_data,						//数据流
	output 					avalon_st_tx_error,						//发送错误信号
	output 		[1:0] 		avalon_st_pause_data,					//发送停止信号
	
	input					avalon_st_rx_startofpacket,				//数据流开头
	input					avalon_st_rx_endofpacket,				//数据流结尾
	input					avalon_st_rx_valid,						//数据流信号有效
	output					avalon_st_rx_ready,						//用户已准备好接收数据
	input		[63:0]		avalon_st_rx_data,						//数据流
	input		[2:0]		avalon_st_rx_empty,						//数据流结尾未使用的字符
	input		[5:0]		avalon_st_rx_error,						//接收错误类型信号
	
	input					tx_start,								//用户指示开始发送UDP数据包
	output 					tx_idle,								//用以指示用户是否正处于空闲状态
	
	output 		[63:0]		wr_data,								//写入fifo的数据
	output 					wr_req,									//fifo写请求
	output					rx_finish,								//接收到一次数据
	
	input		[15:0]		data_length,							//待发送数据长度
	output					rd_req,									//fifo读请求
	input		[63:0]		rd_data									//fifo读出的数据
);

parameter mac_src_addr	= 48'h00_0A_35_01_FE_C0; 					//源地址
parameter mac_type_ip 	= 16'h0800;									//类型字段（0800为IP数据报）
parameter mac_type_arp 	= 16'h0806;									//类型字段（0806为ARP帧）
parameter ip_src_addr 	= 32'hc0a80002;								//192.168.0.2	源IP地址
parameter ip_dst_addr 	= 32'hc0a80003;								//192.168.0.3	目的IP地址

wire[47:0] r_mac_dst_addr;
wire[15:0] r_mac_type;
wire arp_op;
wire rx_receive;
Eth_10g_receive_from_10gmac Eth_10g_receive_from_10gmac_inst
(
	.clk_156_25(clk_156_25),											//	input  				//PHY和MAC的时钟156.25MHz
	.rst_n(rst_n),														// input				//复位信号
	.avalon_st_rx_startofpacket(avalon_st_rx_startofpacket) ,			// input				//数据流开头
	.avalon_st_rx_endofpacket(avalon_st_rx_endofpacket) ,				// input                //数据流结尾
	.avalon_st_rx_valid(avalon_st_rx_valid) ,							// input                //数据流信号有效
	.avalon_st_rx_ready(avalon_st_rx_ready) ,							// output               //用户已准备好接收数据
	.avalon_st_rx_data(avalon_st_rx_data) ,								// input [63:0]         //数据流
	.avalon_st_rx_empty(avalon_st_rx_empty) ,							// input [2:0]          //数据流结尾未使用的字符
	.avalon_st_rx_error(avalon_st_rx_error) ,							// input [5:0]          //接收错误类型信号
	
	.mac_dst_addr(r_mac_dst_addr),										//	output[47:0]		//目的地址
	.mac_src_addr(mac_src_addr),                            			// input[47:0]			//源地址
	.mac_type(r_mac_type),                                 				// output[15:0]			//类型字段（0800为IP数据报）
	
	.arp_op(arp_op),													// output reg			//当接收到一次ARP请求时，产生一个脉冲

	.ip_src_addr(ip_src_addr),											// input[31:0]			//192.168.0.2	源IP地址
	.ip_dst_addr(ip_dst_addr),                              			// input[31:0]			//192.168.0.3	目的IP地址
	
	.wr_data(wr_data),													// output reg[63:0]		//写入fifo的数据
	.wr_req(wr_req),                             						// output reg			//fifo写请求
	
	.rx_receive(rx_receive)												// output reg			//当完成一次数据的接收时，产生一个脉冲
);

Eth_10g_send_to_10gmac Eth_10g_send_to_10gmac_inst(
	.clk_156_25(clk_156_25),											//	input  					//PHY和MAC的时钟156.25MHz
	.rst_n(rst_n),														// input					//复位信号
	.avalon_st_tx_startofpacket(avalon_st_tx_startofpacket),			//	output 	 				//数据流开头
	.avalon_st_tx_valid(avalon_st_tx_valid),							//	output 	 				//数据流信号有效
	.avalon_st_tx_ready(avalon_st_tx_ready),							//	input  					//MAC已准备好接收数据
	.avalon_st_tx_endofpacket(avalon_st_tx_endofpacket),				//	output 	 				//数据流结尾
	.avalon_st_tx_empty(avalon_st_tx_empty),							//	output 		[2:0]		//数据流结尾未使用的字符
	.avalon_st_tx_data(avalon_st_tx_data),								//	output 		[63:0]		//数据流
	.avalon_st_tx_error(avalon_st_tx_error),							//	output 					//发送错误信号
	.avalon_st_pause_data(avalon_st_pause_data),          				// output 		[1:0]    	//发送停止信号

	.mac_dst_addr(mac_dst_addr),										//	input[47:0]				//目的地址
	.mac_src_addr(mac_src_addr),                          				// input[47:0]				//源地址
	.mac_type(mac_type),                                				// input[15:0]				//类型字段（0806为ARP帧、0800为UDP）
	.arp_op(arp_state),													// input					//ARP操作类型(1为应答、0为请求)
	.ip_src_addr(ip_src_addr),											// input[31:0]				//192.168.0.2	源IP地址
	.ip_dst_addr(ip_dst_addr),                            				// input[31:0]				//192.168.0.3	目的IP地址

	.tx_start(r_tx_start),												//	input					//用户指示开始发送ARP数据包
	.tx_idle(r_tx_idle),												//	output 					//用以指示用户是否正处于空闲状态

	.data_length(data_length),											//	input			[15:0]	//待发送数据长度
	.rd_req(rd_req),													// output					//fifo读请求
	.rd_data(rd_data)													// input			[63:0]	//fifo读出的数据
);

//当接收到一次arp请求则发送arp应答
reg arp_state;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		arp_state <= 1'b0;
	end
	else if(arp_op)begin
		arp_state <= 1'b1;
	end
	else if(r_tx_start)begin
		arp_state <= 1'b0;
	end
	else begin
		arp_state <= arp_state;
	end
end

//当接收到一次arp请求或arp应答则修改目的mac地址
reg[47:0] mac_dst_addr;// = 48'h90_E2_BA_7D_BF_0D;						//目的地址
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		mac_dst_addr <= 48'hff_ff_ff_ff_ff_ff;
	end
	else if(rx_receive && (r_mac_type == mac_type_arp))begin
		mac_dst_addr <= r_mac_dst_addr;
	end
	else begin
		mac_dst_addr <= mac_dst_addr;
	end
end

//发送arp应答
reg[15:0] mac_type;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		mac_type <= mac_type_ip;
	end
	else if(arp_state)begin
		mac_type <= mac_type_arp;
	end
	else begin
		mac_type <= mac_type_ip;
	end
end

wire r_tx_idle;
assign tx_idle = r_tx_idle & (~arp_state);

//启动发送arp应答
reg r_tx_start;
always @(posedge clk_156_25, negedge rst_n)begin
	if(~rst_n)begin
		r_tx_start <= 1'b0;
	end
	else if(~arp_state)begin
		r_tx_start <= tx_start;
	end
	else if(~r_tx_idle)begin
		r_tx_start <= 1'b0;
	end
	else begin
		r_tx_start <= 1'b1;
	end
end

assign rx_finish = rx_receive && (r_mac_type == mac_type_ip);

endmodule
