module mux8to1(cntrl, results, out);

	input logic [2:0] cntrl;
	input logic [7:0] results;
	logic [1:0] muxOut4_1;
	output logic out;

	

	
	mux4_1 mux4_1_1(.out(muxOut4_1[0]), .i00(results[0]), .i01(results[1]), 
						 .i10(results[2]), .i11(results[3]), .sel0(cntrl[0]), .sel1(cntrl[1]));

	mux4_1 mux4_1_2(.out(muxOut4_1[1]), .i00(results[4]), .i01(results[5]), 
						 .i10(results[6]), .i11(results[7]), .sel0(cntrl[0]), .sel1(cntrl[1]));
						 	
	mux2_1 muxout(.out(out), .i0(muxOut4_1[0]), .i1(muxOut4_1[1]), .sel(cntrl[2]));
									 	 

endmodule