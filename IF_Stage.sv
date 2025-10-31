
`timescale 1ps/1ps 

import structures::*;


module IF_Stage (
			
			pc_src, 
			instruction, 
			pc_write, 
			pc_br,
			clk, 
			rst,
			pc

			
		);


	input logic 					rst, clk;
	input logic 					pc_src;
	input logic 					pc_write;
	input logic 	[63:0] 		pc_br;	
	
	output logic 	[31:0] 		instruction;
	logic 			[63:0] 		pc_next;
	
	logic 			[63:0] 		pc_add4;
	output logic 	[63:0] 		pc;



	
// ------------------ PC input -------------------------

	genvar i;
		generate
			for(i = 0; i < 64; i++) begin: pc_src_muxs
				mux2_1 pc_src_mux(.out(pc_next[i]), .i0(pc_add4[i]), .i1(pc_br[i]), .sel(pc_src));
				
			end
		endgenerate
	
	
// ================ Program Counter =================


	genvar z;
		generate			
			for(z = 0; z < 64; z++) begin : pc_regs
				singleReg writetoregister(.enable(pc_write), .writeData(pc_next[z]), .reset(rst),
												  .clk(clk), .out(pc[z]));
			end	
	endgenerate	
	
	
	Adder PC_Add4(.A(pc), .B(64'h0000000000000004), .result(pc_add4));
	

// =============== instruction mem ================
		
	instructmem instructFetch(.address(pc), .instruction(instruction), .clk(clk)); //PC ---> instructmem
	
	
endmodule 