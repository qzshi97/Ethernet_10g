module Eth_10g_mac(
	input system_clk,
	input  pll_ref_clk,
	output clk_156_25,
	input rst_n,
	
	input  avalon_st_tx_startofpacket,
	input  avalon_st_tx_valid,
	input [63:0] avalon_st_tx_data,
	input [2:0] avalon_st_tx_empty,
	output  avalon_st_tx_ready,
	input avalon_st_tx_error,
	input avalon_st_tx_endofpacket,
	input [1:0] avalon_st_pause_data,
	
	output  avalon_st_rx_startofpacket,
	output  avalon_st_rx_endofpacket,
	output  avalon_st_rx_valid,
	input  avalon_st_rx_ready,
	output [63:0] avalon_st_rx_data,
	output [2:0] avalon_st_rx_empty,
	output [5:0] avalon_st_rx_error,
	
	input rx_serial_data,
	output tx_serial_data
);

wire r_clk_156_25;
wire [71:0] xgmii_rx_data;
wire [71:0] xgmii_tx_data;
wire tx_ready;
wire rx_ready;
assign clk_156_25 = r_clk_156_25;

Eth_10gmac Eth_10gmac_inst
(
	.csr_clk_clk(system_clk) ,																// input  system_clk
	.csr_reset_reset_n(rst_n) ,															// input  csr_reset_reset_n_sig
	.csr_address(13'b0) ,																	// input [12:0] csr_address_sig
	.csr_waitrequest() ,																		// output  csr_waitrequest_sig
	.csr_read(1'b0) ,																			// input  csr_read_sig
	.csr_readdata() ,																			// output [31:0] csr_readdata_sig
	.csr_write(1'b0) ,																		// input  csr_write_sig
	.csr_writedata(32'b0) ,																	// input [31:0] csr_writedata_sig
	
	.tx_clk_clk(r_clk_156_25) ,															// input  tx_clk_clk_sig
	.tx_reset_reset_n(tx_ready) ,															// input  tx_reset_reset_n_sig
	.avalon_st_tx_startofpacket(avalon_st_tx_startofpacket) ,					// input  avalon_st_tx_startofpacket_sig
	.avalon_st_tx_valid(avalon_st_tx_valid) ,											// input  avalon_st_tx_valid_sig
	.avalon_st_tx_data(avalon_st_tx_data) ,											// input [63:0] avalon_st_tx_data_sig
	.avalon_st_tx_empty(avalon_st_tx_empty) ,											// input [2:0] avalon_st_tx_empty_sig
	.avalon_st_tx_ready(avalon_st_tx_ready) ,											// output  avalon_st_tx_ready_sig
	.avalon_st_tx_error(avalon_st_tx_error) ,											// input [0:0] avalon_st_tx_error_sig
	.avalon_st_tx_endofpacket(avalon_st_tx_endofpacket) ,							// input  avalon_st_tx_endofpacket_sig
	.avalon_st_pause_data(avalon_st_pause_data) ,									// input [1:0] avalon_st_pause_data_sig
	
	.xgmii_tx_data(xgmii_tx_data) ,														// output [71:0] xgmii_tx_data_sig
	.xgmii_rx_data(xgmii_rx_data) ,														// input [71:0] xgmii_rx_data_sig
	
	.rx_clk_clk(r_clk_156_25) ,															// input  rx_clk_clk_sig
	.rx_reset_reset_n(rx_ready) ,															// input  rx_reset_reset_n_sig
	.avalon_st_rx_startofpacket(avalon_st_rx_startofpacket) ,					// output  avalon_st_rx_startofpacket_sig
	.avalon_st_rx_endofpacket(avalon_st_rx_endofpacket) ,							// output  avalon_st_rx_endofpacket_sig
	.avalon_st_rx_valid(avalon_st_rx_valid) ,											// output  avalon_st_rx_valid_sig
	.avalon_st_rx_ready(avalon_st_rx_ready) ,											// input  avalon_st_rx_ready_sig
	.avalon_st_rx_data(avalon_st_rx_data) ,											// output [63:0] avalon_st_rx_data_sig
	.avalon_st_rx_empty(avalon_st_rx_empty) ,											// output [2:0] avalon_st_rx_empty_sig
	.avalon_st_rx_error(avalon_st_rx_error) ,											// output [5:0] avalon_st_rx_error_sig
	
	.avalon_st_rxstatus_valid() ,															// output  avalon_st_rxstatus_valid_sig
	.avalon_st_rxstatus_data() ,															// output [39:0] avalon_st_rxstatus_data_sig
	.avalon_st_rxstatus_error() ,															// output [6:0] avalon_st_rxstatus_error_sig
	.link_fault_status_xgmii_rx_data() 													// output [1:0] link_fault_status_xgmii_rx_data_sig
);


Eth_10gbaser_phy Eth_10gbaser_phy_inst
(
	.pll_ref_clk(pll_ref_clk) ,								// input  pll_ref_clk_sig
	.xgmii_rx_clk(r_clk_156_25) ,								// output  xgmii_rx_clk_sig
	.tx_ready(tx_ready) , 										// output  tx_ready_sig
	.xgmii_tx_clk(r_clk_156_25) ,								// input  xgmii_tx_clk_sig
	.rx_ready(rx_ready) , 										// output  rx_ready_sig
	.rx_data_ready() , 											// output [0:0] rx_data_ready_sig
	
	.xgmii_rx_dc_0(xgmii_rx_data) ,							// output [71:0] xgmii_rx_dc_0_sig
	.xgmii_tx_dc_0(xgmii_tx_data) ,							// input [71:0] xgmii_tx_dc_0_sig
			
	.rx_serial_data_0(rx_serial_data) ,						// input  rx_serial_data_0_sig	
	.tx_serial_data_0(tx_serial_data) ,						// output [0:0] tx_serial_data_0_sig
	
	.reconfig_from_xcvr() ,										// output [91:0] reconfig_from_xcvr_sig
	.reconfig_to_xcvr() ,										// input [139:0] reconfig_to_xcvr_sig
			
	.phy_mgmt_clk(system_clk) ,								// input  phy_mgmt_clk_sig
	.phy_mgmt_clk_reset(~rst_n) ,								// input  phy_mgmt_clk_reset_sig
	.phy_mgmt_address(9'b0) ,									// input [8:0] phy_mgmt_address_sig
	.phy_mgmt_read(1'b0) ,										// input  phy_mgmt_read_sig
	.phy_mgmt_readdata() ,										// output [31:0] phy_mgmt_readdata_sig
	.phy_mgmt_write(1'b0) ,										// input  phy_mgmt_write_sig
	.phy_mgmt_writedata(32'b0) ,								// input [31:0] phy_mgmt_writedata_sig
	.phy_mgmt_waitrequest() 									// output  phy_mgmt_waitrequest_sig
);
endmodule

