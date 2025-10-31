//module ProgramCounter(PC, PCnext, PCAdd4, clk, rst);
//
//
//	input  logic 	[63:0] PCNext;
//	input  logic			 clk, rst;
//
//	output logic 	[63:0] PC;
//	output logic 	[63:0] pcAdd4;
//		
//	genvar z;
//		generate			
//			for(z = 0; z < 64; z++) begin : PCregs
//				singleReg writetoregister(.enable(1'b1), .writeData(PCNext[z]), .reset(rst),
//												  .clk(clk), .out(PC[z]));
//			end	
//	endgenerate	
//	
//endmodule 
//		
//	