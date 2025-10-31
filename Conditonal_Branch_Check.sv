


`timescale 1ps/1ps


import structures::*; 


module Conditonal_Branch_Check (


		read_data_1,
		read_data_2,
		instruction,
		branch,
		cbz_op,
		blt_op,
		flags,
		b_type,
		
		br_taken

	);
	
	input logic 	[63:0]		read_data_1, read_data_2;
	input logic 	[31:0]		instruction;
	input logic 					branch;
	input logic 					cbz_op;
	input logic 					blt_op;
	input logic 	[3:0]			flags;
	input logic						b_type;
	
	output logic					br_taken;
	

	
	//===================== B.LT logic ======================
	
	logic 			neg_xor_overflow;
	logic 			not_zero_flag;
	logic 			pass_blt;
	
	xor #50 (neg_xor_overflow, flags[0], flags[2]);
	not #50 (not_zero_flag, flags[1]);
	and #50 (pass_blt, not_zero_flag, neg_xor_overflow, blt_op);
		
	
	//===================== CBZ logic ======================
	
	logic 			rd_not_zero;
	logic [63:0]	or_bits;
	logic 			pass_cbz;
	logic 			cbz_con_met;
	
	or #50 (or_bits[0], 1'b0, read_data_2[0]);

	genvar x;
		generate
			for(x = 1; x < 64; x++) begin: cbz_or_loop
			
				or #50 (or_bits[x], or_bits[x-1], read_data_2[x]);
				
		end
	endgenerate
	
	not #50 (cbz_con_met, or_bits[63]);
	
	
	and #50 (pass_cbz, cbz_con_met, cbz_op);
	
	

	or	 #50 (br_taken, pass_cbz, pass_blt, b_type);
	

endmodule 