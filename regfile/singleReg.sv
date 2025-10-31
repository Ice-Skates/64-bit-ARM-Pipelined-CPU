module singleReg (enable, writeData, out, reset, clk);
	
	input logic enable;
	input logic reset;
	input logic writeData;
	input logic clk;
	output logic out;
	
	logic  muxOutput;
	
			mux2_1 mux2_1loop(.out(muxOutput), .i0(out), .i1(writeData), .sel(enable));
			D_FF d_ff (.q(out), .d(muxOutput), .reset(reset), .clk(clk));
				

endmodule
		
