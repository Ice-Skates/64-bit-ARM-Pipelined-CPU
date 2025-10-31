
import structures::*;

`timescale 1ps/1ps 

module MEM_WB_reg	(


	
		//inputs

		mem_read_data,		
		mem_ALU_result,		
		mem_WB,				
		mem_Rd,
		clk,
		rst,

		
		//outputs
		
		wb_read_data,			
		wb_ALU_result,		
		wb_Rd,					
		wb_WB					


	);
	
	
	input logic [63:0]		mem_read_data;
	input logic [63:0]		mem_ALU_result;
	input logic [4:0]			mem_Rd;
	input logic 				clk, rst;
	
	input struct_WB 			mem_WB;
	
	output logic [63:0]		wb_read_data;
	output logic [63:0]		wb_ALU_result;
	output logic [4:0]		wb_Rd;
	
	output struct_WB 			wb_WB;
	
	
	genvar x;
		generate			
			for(x = 0; x < 64; x++) begin : wb_mem_Rd_reg_loop
				singleReg wb_mem_Rd_reg(.enable(1'b1), .writeData(mem_Rd[x]), .reset(rst),
												  .clk(clk), .out(wb_Rd[x]));
			end	
	endgenerate	

	
	genvar a;
		generate			
			for(a = 0; a < 2; a++) begin : wb_WB_reg_loop
				singleReg wb_WB_reg(.enable(1'b1), .writeData(mem_WB[a]), .reset(rst),
												  .clk(clk), .out(wb_WB[a]));
			end	
	endgenerate	
	
	
	genvar c;
		generate			
			for(c = 0; c < 64; c++) begin : wb_read_data_reg_loop
				singleReg wb_read_data_reg_(.enable(1'b1), .writeData(mem_read_data[c]), .reset(rst),
												  .clk(clk), .out(wb_read_data[c]));
			end	
	endgenerate	
	

	genvar y;
		generate			
			for(y = 0; y < 64; y++) begin : wb_ALU_result_reg_loop
				singleReg wb_ALU_result_reg(.enable(1'b1), .writeData(mem_ALU_result[y]), .reset(rst),
												  .clk(clk), .out(wb_ALU_result[y]));
			end	
	endgenerate	
	

endmodule 