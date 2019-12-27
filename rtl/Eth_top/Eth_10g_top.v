module Eth_10g_top(
	input system_clk,				//系统时钟
	input  pll_ref_clk,				//phy层参考时钟644.53125MHz
	output clk_156_25,				//PHY和MAC的时钟156.25MHz
	input rst_n,					//复位信号

	input tx_start,					//用户指示开始发送数据包（发送数据时，需要持续拉高直至tx_idle被拉低）
	output tx_idle,                 //用以指示用户是否正处于空闲状态
	
	output[63:0]wr_data,			//写入fifo的数据
	output wr_req,                  //fifo写请求
	output rx_finish,               //接收到一次数据
	
	input [15:0] data_length,		//待发送数据长度
	output rd_req,					//fifo读请求
	input [63:0]rd_data,            //fifo读出的数据
	
	input rx_serial_data,			//串行输入信号
	output tx_serial_data			//串行输出信号
);

wire r_clk_156_25;
wire avalon_st_tx_startofpacket_sig;
wire avalon_st_tx_valid_sig;
wire avalon_st_tx_ready_sig;
wire avalon_st_tx_endofpacket_sig;
wire [2:0] avalon_st_tx_empty_sig;
wire [63:0] avalon_st_tx_data_sig;
wire avalon_st_tx_error_sig;
wire avalon_st_pause_data_sig;

wire avalon_st_rx_startofpacket_sig;
wire avalon_st_rx_endofpacket_sig;
wire avalon_st_rx_valid_sig;
wire avalon_st_rx_ready_sig;
wire [63:0] avalon_st_rx_data_sig;
wire [2:0] avalon_st_rx_empty_sig;
wire [5:0] avalon_st_rx_error_sig;

assign clk_156_25 = r_clk_156_25;
Eth_top Eth_top_inst
(
	.clk_156_25(r_clk_156_25),												//	input  					//PHY和MAC的时钟156.25MHz
	.rst_n(rst_n),															// input						//复位信号
	
	.avalon_st_tx_startofpacket(avalon_st_tx_startofpacket_sig),			//	output 	 				//数据流开头
	.avalon_st_tx_valid(avalon_st_tx_valid_sig),							//	output 	 				//数据流信号有效
	.avalon_st_tx_ready(avalon_st_tx_ready_sig),							//	input  					//MAC已准备好接收数据
	.avalon_st_tx_endofpacket(avalon_st_tx_endofpacket_sig),				//	output 	 				//数据流结尾
	.avalon_st_tx_empty(avalon_st_tx_empty_sig),							//	output 		[2:0]		//数据流结尾未使用的字符
	.avalon_st_tx_data(avalon_st_tx_data_sig),								//	output 		[63:0]	//数据流
	.avalon_st_tx_error(avalon_st_tx_error_sig),							//	output 					//发送错误信号
	.avalon_st_pause_data(avalon_st_pause_data_sig),               			// output 		[1:0]    //发送停止信号

	.avalon_st_rx_startofpacket(avalon_st_rx_startofpacket_sig) ,			// input						//数据流开头
	.avalon_st_rx_endofpacket(avalon_st_rx_endofpacket_sig) ,				// input                //数据流结尾
	.avalon_st_rx_valid(avalon_st_rx_valid_sig) ,							// input                //数据流信号有效
	.avalon_st_rx_ready(avalon_st_rx_ready_sig) ,							// output               //用户已准备好接收数据
	.avalon_st_rx_data(avalon_st_rx_data_sig) ,								// input [63:0]         //数据流
	.avalon_st_rx_empty(avalon_st_rx_empty_sig) ,							// input [2:0]          //数据流结尾未使用的字符
	.avalon_st_rx_error(avalon_st_rx_error_sig) ,							// input [5:0]          //接收错误类型信号
	
	.tx_start(tx_start),													//	input						//用户指示开始发送UDP数据包
	.tx_idle(tx_idle),														//	output 					//用以指示用户是否正处于空闲状态

	.wr_data(wr_data),														// output reg[63:0]		//写入fifo的数据
	.wr_req(wr_req),                             							// output reg				//fifo写请求
	.rx_finish(rx_finish),													// output					//接收到一次数据
	
	.data_length(data_length),												//	input			[15:0]	//待发送数据长度
	.rd_req(rd_req),														// output					//fifo读请求
	.rd_data(rd_data)														// input			[63:0]	//fifo读出的数据

);

Eth_10g_mac Eth_10g_mac_inst
(
	.system_clk(system_clk),
	.pll_ref_clk(pll_ref_clk),
	.clk_156_25(r_clk_156_25),
	.rst_n(rst_n),

	.avalon_st_tx_startofpacket(avalon_st_tx_startofpacket_sig) ,			// input  avalon_st_tx_startofpacket_sig
	.avalon_st_tx_valid(avalon_st_tx_valid_sig) ,							// input  avalon_st_tx_valid_sig
	.avalon_st_tx_data(avalon_st_tx_data_sig) ,								// input [63:0] avalon_st_tx_data_sig
	.avalon_st_tx_empty(avalon_st_tx_empty_sig) ,							// input [2:0] avalon_st_tx_empty_sig
	.avalon_st_tx_ready(avalon_st_tx_ready_sig) ,							// output  avalon_st_tx_ready_sig
	.avalon_st_tx_error(avalon_st_tx_error_sig) ,							// input [0:0] avalon_st_tx_error_sig
	.avalon_st_tx_endofpacket(avalon_st_tx_endofpacket_sig) ,				// input  avalon_st_tx_endofpacket_sig
	.avalon_st_pause_data(avalon_st_pause_data_sig) ,						// input [1:0] avalon_st_pause_data_sig
	
	.avalon_st_rx_startofpacket(avalon_st_rx_startofpacket_sig) ,			// output  avalon_st_rx_startofpacket_sig
	.avalon_st_rx_endofpacket(avalon_st_rx_endofpacket_sig) ,				// output  avalon_st_rx_endofpacket_sig
	.avalon_st_rx_valid(avalon_st_rx_valid_sig) ,							// output  avalon_st_rx_valid_sig
	.avalon_st_rx_ready(avalon_st_rx_ready_sig) ,							// input  avalon_st_rx_ready_sig
	.avalon_st_rx_data(avalon_st_rx_data_sig) ,								// output [63:0] avalon_st_rx_data_sig
	.avalon_st_rx_empty(avalon_st_rx_empty_sig) ,							// output [2:0] avalon_st_rx_empty_sig
	.avalon_st_rx_error(avalon_st_rx_error_sig) ,							// output [5:0] avalon_st_rx_error_sig
	
	.rx_serial_data(rx_serial_data) ,										// input  rx_serial_data_0_sig	
	.tx_serial_data(tx_serial_data) 										// output [0:0] tx_serial_data_0_sig
);


endmodule

