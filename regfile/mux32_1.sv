module mux32_1(registers, ReadRegister, out);

	input logic [31:0] registers;
	input logic [4:0] ReadRegister;
	output logic out;
	
	logic [7:0] muxOut1;
	logic [1:0] muxOut2;

	genvar i;
		generate
			for(i = 0; i < 32; i = i + 4) begin: firstMuxs
			

			
				mux4_1 mux4_1_8(.out(muxOut1[i/4]), .i00(registers[i]), .i01(registers[i + 1]), .i10(registers[i + 2]),
									 .i11(registers[i + 3]), .sel0(ReadRegister[0]), .sel1(ReadRegister[1]));
									 
			end
			
		endgenerate

	
	mux4_1 mux4_1_21(.out(muxOut2[0]), .i00(muxOut1[0]), .i01(muxOut1[1]), 
						 .i10(muxOut1[2]), .i11(muxOut1[3]), .sel0(ReadRegister[2]), .sel1(ReadRegister[3]));

	mux4_1 mux4_1_22(.out(muxOut2[1]), .i00(muxOut1[4]), .i01(muxOut1[5]), 
						 .i10(muxOut1[6]), .i11(muxOut1[7]), .sel0(ReadRegister[2]), .sel1(ReadRegister[3]));
						 	
	mux2_1 muxout(.out(out), .i0(muxOut2[0]), .i1(muxOut2[1]), .sel(ReadRegister[4]));
									 	 
		





endmodule