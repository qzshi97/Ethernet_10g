module tx_src(
	input 				rst_n,
	output [15:0] 		data_length,
	output reg			tx_start,
	input 				tx_idle,
	
	input 				rx_finish,
	input[63:0] 		rx_data,
	input				rx_wr_req,
	
	
	input 				wrfull,
	output reg[63:0] 	data_sig,
	output reg			wrreq_sig,
	input 				wrclk_sig

);

////////////////////////回环测试////////////////////////////
assign data_length = 16'd1448;

always @(posedge wrclk_sig, negedge rst_n)begin
	if(~rst_n)begin
		wrreq_sig <= 1'b0;
		data_sig <= 64'b0;
	end
	else begin
		wrreq_sig <= rx_wr_req;
		data_sig <= rx_data;
	end
end

wire pos;
assign pos = tx_start & (~r_start);
reg r_start;
always @(posedge wrclk_sig, negedge rst_n)begin
	if(~rst_n)begin
		r_start <= 1'b0;
	end
	else begin
		r_start <= tx_start;
	end
end
reg[23:0] cnt;
always @(posedge wrclk_sig, negedge rst_n)begin
	if(~rst_n)begin
		cnt <= 16'b0;
	end
	else if(rx_finish)begin
		cnt <= cnt + 1'b1;
	end
	else if(pos)begin
		cnt <= cnt - 1'b1;
	end
end

always @(posedge wrclk_sig, negedge rst_n)begin
	if(~rst_n)begin
		tx_start <= 1'b0;
	end
	else if(tx_idle)begin
		if(cnt > 24'b0)begin
			tx_start <= 1'b1;
		end
		else begin
			tx_start <= 1'b0;
		end
	end
	else begin
		tx_start <= 1'b0;
	end
end
////////////////////////////////////////////////////////////





////////////////////////////UDP test///////////////////////
// assign data_length = 16'd1450;
// reg[255:0] data;
// always @(posedge wrclk_sig, negedge rst_n)begin
	// if(~rst_n)begin
		// wrreq_sig <= 1'b0;
		// data_sig <= 64'b0;
		// data <= "This is a test of the 10 Gb mac.";
	// end
	// else if(~wrfull)begin
		// wrreq_sig <= 1'b1;
		// data_sig <= data[255:192];
		// data <= {data[191:0],data[255:192]};
	// end
	// else begin
		// wrreq_sig <= 1'b0;
		// data_sig <= 64'b0;
	// end
// end

// always @(posedge wrclk_sig, negedge rst_n)begin
	// if(~rst_n)begin
		// tx_start <= 1'b0;
	// end
	// else if(tx_idle)begin
		// tx_start <= 1'b1;
	// end
	// else begin
		// tx_start <= 1'b0;
	// end
// end
////////////////////////////////////////////////////////////////////


////////////////////////ARP test////////////////////////////////
// assign data_length = 16'd128;
// reg[23:0] cnt;
// always @(posedge wrclk_sig, negedge rst_n)begin
	// if(~rst_n)begin
		// cnt <= 16'b0;
	// end
	// else if(cnt == 24'h00ffff)begin
		// cnt <= 16'b0;
	// end
	// else begin
		// cnt <= cnt + 1'b1;
	// end
// end

// always @(posedge wrclk_sig, negedge rst_n)begin
	// if(~rst_n)begin
		// tx_start <= 1'b0;
	// end
	// else if(tx_idle)begin
		// if(cnt == 24'h00ffff)begin
			// tx_start <= 1'b1;
		// end
		// else begin
			// tx_start <= 1'b0;
		// end
	// end
	// else begin
		// tx_start <= 1'b0;
	// end
// end
////////////////////////////////////////////////////////////









endmodule
