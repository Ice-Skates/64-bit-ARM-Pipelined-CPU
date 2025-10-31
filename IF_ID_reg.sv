


`timescale 1ps/1ps

import structures::*; 


module IF_ID_reg(	clk, rst, IF_ID_write, if_flush,
						instruction_in, pc_in, instruction_out, pc_out);


	input logic				 clk, rst;
	input logic				 IF_ID_write;
	input logic 	[31:0] instruction_in;
	input logic 	[63:0] pc_in;
	input logic				 if_flush;
	
	output logic 	[31:0] instruction_out;
	output logic 	[63:0] pc_out;
	
	logic						 rst_or_flush;
	
	or #50 (rst_or_flush, rst, if_flush);

	
	genvar y;
		generate			
			for(y = 0; y < 64; y++) begin : pc_reg_loop
				singleReg pc_reg(.enable(IF_ID_write), .writeData(pc_in[y]), .reset(rst_or_flush),
												  .clk(clk), .out(pc_out[y]));
			end	
	endgenerate	
	
	
	
	genvar z;
		generate			
			for(z = 0; z < 32; z++) begin : instruct_reg_loop
				singleReg instruct_reg(.enable(IF_ID_write), .writeData(instruction_in[z]), .reset(rst_or_flush),
												  .clk(clk), .out(instruction_out[z]));
			end	
	endgenerate	

	
endmodule
	