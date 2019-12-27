module Ethernet_10g(

	input OSC_50_B3B,
//	input OSC_50_B4A,
//	input OSC_50_B4D,
//	input OSC_50_B7A,
//	input OSC_50_B7D,
//	input OSC_50_B8A,
//	input OSC_50_B8D,

	//////////// LMK04906B External PLL //////////
//	input FMCA_ONBOARD_REFCLK_644M53125,
//	input FMCB_ONBOARD_REFCLK_644M53125,
//	input FMCC_ONBOARD_REFCLK_644M53125,
//	input FMCD_ONBOARD_REFCLK_644M53125,

	output LMK04906_CLK,
	output LMK04906_DATAIN,
	output LMK04906_LE,
	
	output sample_clk,
	
	input rx_serial_data_0_sig,
	output tx_serial_data_0_sig,
	
	input pll_ref_clk_sig,
	input rst_n

);

wire system_clk;
wire clk_156_25;

pll pll_inst
(
	.refclk(OSC_50_B3B) ,			// input  refclk_sig
	.rst(~rst_n) ,						// input  rst_sig
	.outclk_0(system_clk) ,			// output  outclk_0_sig
	.outclk_1(sample_clk) 			// output  outclk_1_sig
);

//=======================================================
//  External PLL LMK04906 Configuration =================
//=======================================================
//wire lmk04906_spi_done;
SPI_LMK04906_Config  SPI_LMK04906_Config_inst(
	.clk50(OSC_50_B3B), //50MHZ
	.rst_n(rst_n),
	.iFREQ_SELECT(4'hf),//FMCA=1|FMCD=1|FMCB=1|FMCC=1

	// spi
	.LMK04906_CLK(LMK04906_CLK),
	.LMK04906_DATAIN(LMK04906_DATAIN),
	.LMK04906_LE(LMK04906_LE),
	.SPI_DONE()
);

wire			tx_start;
wire			tx_idle;
wire [15:0]		data_length;
wire rx_finish;
tx_src tx_src_inst(
	.rst_n(rst_n),
	.data_length(data_length),
	.tx_start(tx_start),
	.tx_idle(tx_idle),
	.rx_finish(rx_finish),

	.wrfull(wrfull),
	
	.rx_data(data),
	.rx_wr_req(wrreq),
	
	.data_sig(data_sig),
	.wrreq_sig(wrreq_sig),
	.wrclk_sig(clk_156_25)

);

wire [63:0] 	data;
wire			wrreq;

wire[63:0] 		q_sig;
wire 			rdreq_sig;
wire [63:0] 	data_sig;
wire			wrreq_sig;
wire 			wrfull;
tx_fifo tx_fifo_inst
(
	.aclr(~rst_n),
	
	.wrfull(wrfull),
	.data(data_sig) ,			// input [63:0] data_sig
	.rdclk(clk_156_25) ,		// input  rdclk_sig
	.rdreq(rdreq_sig) ,		// input  rdreq_sig
	.wrclk(clk_156_25) ,		// input  wrclk_sig
	.wrreq(wrreq_sig) ,		// input  wrreq_sig
	.q(q_sig) 					// output [63:0] q_sig

);

Eth_10g_top Eth_10g_top_inst
(
	.system_clk(system_clk),
	.pll_ref_clk(pll_ref_clk_sig),
	.clk_156_25(clk_156_25),
	.rst_n(rst_n),
	
	.tx_idle(tx_idle),															//	output 					//用以指示用户是否正处于空闲状态
	.data_length(data_length),													//	input			[15:0]	//待发送数据长度
	.tx_start(tx_start),															//	input						//用户指示开始发送UDP数据包
	
	.wr_req(wrreq),                             					// output reg				//fifo写请求
	.wr_data(data),															// output reg[63:0]		//写入fifo的数据
	.rx_finish(rx_finish),
	
	.rd_req(rdreq_sig),															// output					//fifo读请求
	.rd_data(q_sig),																// input			[63:0]	//fifo读出的数据
	
	.rx_serial_data(rx_serial_data_0_sig) ,								// input  rx_serial_data_0_sig	
	.tx_serial_data(tx_serial_data_0_sig) 									// output [0:0] tx_serial_data_0_sig
);

endmodule
