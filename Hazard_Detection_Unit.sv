


`timescale 1ps/1ps


import structures::*; 




module Hazard_Detection_Unit(

		id_reg_Rn,
		id_reg_Rm,
		ex_reg_Rm,
		ex_mem_read,
		clk,
		rst,
		if_flush,
		br_taken,
		bubble_ctrl,
		IF_ID_write,
		pc_write

	);
	
	input logic [4:0]			id_reg_Rn;
	input logic [4:0]			id_reg_Rm;
	input logic [4:0]			ex_reg_Rm;
	input logic 				ex_mem_read;
	input logic					br_taken;
	input logic					clk, rst;

	output logic				if_flush;
	output logic 				bubble_ctrl;
	output logic				IF_ID_write;
	output logic				pc_write;
	
	logic							br_taken_dff;
	logic							br_taken_dff_2;

	D_FF br_d_ff 	(.q(br_taken_dff), .d(br_taken), .reset(rst), .clk(clk));
	D_FF br_d_ff_2 (.q(br_taken_dff_2), .d(br_taken_dff), .reset(rst), .clk(clk));

	

	always_comb begin
	
		if_flush 	= 1'b0;
		bubble_ctrl = 1'b0;
		IF_ID_write = 1'b1;
		pc_write    = 1'b1;
		
		
		
		if (br_taken_dff) begin
			
			if_flush    = 1'b1;   
			bubble_ctrl = 1'b0;  
			IF_ID_write = 1'b0;  
			pc_write    = 1'b0;   
		
		end
		
		
		else if (br_taken_dff_2) begin
			
			if_flush    = 1'b0;   
			bubble_ctrl = 1'b1;  
			IF_ID_write = 1'b1;  
			pc_write    = 1'b1;   
		
		end

		
		else if (ex_mem_read &&
			(ex_reg_Rm == id_reg_Rn || 
			 ex_reg_Rm == id_reg_Rm)) begin
			
			if_flush 	= 1'b0;
			bubble_ctrl = 1'b1;
			IF_ID_write = 1'b0;
			pc_write		= 1'b0;
				
		end

	end
	
endmodule 