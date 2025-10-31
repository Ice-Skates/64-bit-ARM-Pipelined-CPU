
import structures::*;

`timescale 1ps/1ps 

module WB_Stage (


		//inputs
		
		wb_read_data,			
		wb_ALU_result,		
		wb_WB,
		wb_Rd,
		clk,
		rst,

		id_write_data,	//######### check the outputs 
		id_write_reg,			
		id_reg_write			


	);
	
	
	
	
	
	input logic [63:0]		wb_read_data;
	input logic [63:0]		wb_ALU_result;
	input logic [4:0]			wb_Rd;
	input logic 				clk, rst;
	input struct_WB			wb_WB;
	
	output logic [63:0]		id_write_data;
	output logic [4:0]		id_write_reg;
	output logic 				id_reg_write;
	
	
	genvar n;
		generate 
			for (n = 0; n < 64; n++) begin: ALU_read_data_mux 
			
				mux2_1 ALU_B_mux(
				
				.out(id_write_data[n]), 
				.i0(wb_ALU_result[n]), 
				.i1(wb_read_data[n]), 
				.sel(wb_WB.mem_to_reg)
				
				);
				
		end
	endgenerate
	
	
	genvar x;
		generate 
			for (x = 0; x < 5; x++) begin: write_reg_addr
			
				buf #50 write_reg_addr(id_write_reg[x], wb_Rd[x]);

				
		end
	endgenerate
	
	buf #50 reg_write_set(id_reg_write, wb_WB.reg_write);

	
	
	
endmodule 