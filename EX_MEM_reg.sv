

import structures::*;

`timescale 1ps/1ps 

module EX_MEM_reg(


		//inputs
		
		//pc_br_data,
		ALU_result,
		flags,
		ex_MEM,
		ex_WB,
		ex_Rd,
		ALU_B,
		clk, rst,
		
		//outputs 
		//mem_pc_br_data,
		mem_MEM,
		mem_WB,
		mem_flags,
		mem_ALU_result,
		mem_ALU_B,
		mem_Rd
		


	);
	
	//input logic [63:0] 		pc_br_data; //
	input logic [63:0] 		ALU_result; //
	input logic [3:0] 		flags; // 
	input struct_MEM			ex_MEM; //
	input struct_WB			ex_WB;
	input logic [4:0]			ex_Rd; //
	input logic [63:0]		ALU_B; //
	input logic 				clk, rst;
	
	//output logic [63:0] 		mem_pc_br_data;
	output logic [3:0]		mem_flags;
	output logic [63:0]		mem_ALU_result;
	output logic [63:0]		mem_ALU_B;
	output logic [4:0]		mem_Rd;
	output struct_MEM			mem_MEM;
	output struct_WB			mem_WB;
	


	
	genvar a;
		generate			
			for(a = 0; a < 5; a++) begin : mem_MEM_reg_loop
				singleReg ex_reg(.enable(1'b1), .writeData(ex_MEM[a]), .reset(rst),
												  .clk(clk), .out(mem_MEM[a]));
			end	
	endgenerate	
	
	
	genvar c;
		generate			
			for(c = 0; c < 2; c++) begin : mem_WB_reg_loop
				singleReg wb_reg(.enable(1'b1), .writeData(ex_WB[c]), .reset(rst),
												  .clk(clk), .out(mem_WB[c]));
			end	
	endgenerate	
	

	genvar y;
		generate			
			for(y = 0; y < 64; y++) begin : ALU_result_reg_loop
				singleReg ALU_result_reg(.enable(1'b1), .writeData(ALU_result[y]), .reset(rst),
												  .clk(clk), .out(mem_ALU_result[y]));
			end	
	endgenerate	
	
	
	genvar x;
		generate			
			for(x = 0; x < 64; x++) begin : mem_read_data_2_reg
				singleReg mem_read_data_2_reg(.enable(1'b1), .writeData(ALU_B[x]), .reset(rst),
												  .clk(clk), .out(mem_ALU_B[x]));
			end	
	endgenerate	
	
	
	
	genvar h;
		generate			
			for(h = 0; h < 5; h++) begin : mem_Rd_reg_loop
				singleReg mem_Rd_reg(.enable(1'b1), .writeData(ex_Rd[h]), .reset(rst),
												  .clk(clk), .out(mem_Rd[h]));
			end	
	endgenerate		

//	genvar d;
//		generate			
//			for(d = 0; d < 64; d++) begin : pc_br_data_reg_loop
//				singleReg read_data_1_reg(.enable(1'b1), .writeData(pc_br_data[d]), .reset(rst),
//												  .clk(clk), .out(mem_pc_br_data[d]));
//			end	
//	endgenerate	
//	
//	
	genvar b;
		generate			
			for(b = 0; b < 4; b++) begin : flags_reg_loop
				singleReg flags_reg(.enable(1'b1), .writeData(flags[b]), .reset(rst),
												  .clk(clk), .out(mem_flags[b]));
			end	
	endgenerate	
	//		generate			
//			for(e = 0; e < 32; e++) begin : instruction_reg_loop
//				singleReg instruction_reg(.enable(1'b1), .writeData(instruction_id[e]), .reset(rst),
//												  .clk(clk), .out(instruction_ex[e]));
//			end	
//	endgenerate	
//	

endmodule 