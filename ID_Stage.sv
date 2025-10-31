


`timescale 1ps/1ps


import structures::*; 






module ID_Stage (

			ex_reg_Rm,
			ex_mem_read,
			bubble_ctrl,
			IF_ID_write,
			pc_write,
			pc_id,

			instruction_id, 
			clk, 
			rst, 
			reg_to_loc, 
			write_data, 
			reg_write,  
			wr_reg_addr,
			flags,
			tempFlags,
			ex_setFlags,

			read_data_1,
			read_data_2, 
			se_data,
			id_EX, 
			id_MEM, 
			id_WB,
			if_flush,
			linked_or_Rd,
			pc_out,
			br_taken,
			
			//BR logic
			cbz_or_br,
			forward_id_BR_data,
			forward_idB
			
			);
			
	//Hazard Detect signals
	
	input logic [4:0]			ex_reg_Rm;
	input logic 				ex_mem_read;
	
	output logic 				bubble_ctrl;	//goes to control mux, idk if output needed
	output logic 				IF_ID_write;
	output logic				pc_write;
	
	//inputs
			
	input logic 				clk, rst;
	input logic [31:0] 		instruction_id;
	input logic [63:0] 		write_data;
	input logic [4:0] 		wr_reg_addr;
	input logic 				reg_to_loc;
	input logic					reg_write;
	input logic	[63:0]		pc_id;
	input logic [3:0]			flags, tempFlags;
	input logic 				ex_setFlags;
		
	//outputs
		
	output struct_EX 			id_EX; 	
	output struct_MEM			id_MEM; 	
	output struct_WB			id_WB; 	
	output logic [63:0] 		se_data; 
	output logic [63:0] 		read_data_1, read_data_2;
	output logic [4:0]		linked_or_Rd;
	output logic [63:0]		pc_out;
	
	//logic
	
	logic  [4:0] 				read_reg_2;	
	format_type					sel_se;
	logic							linked_br;
	output logic				br_taken;
	
	//BR logic
	
	logic 						reg_br;
	output logic				cbz_or_br;
	input  logic [63:0]		forward_id_BR_data;
	input  logic				forward_idB;


	
	
	// ###################### Hazard Detection ############################
	
	output logic if_flush;
	
	Hazard_Detection_Unit hazard_detect(

			.id_reg_Rn					(instruction_id[9:5]),
			.id_reg_Rm					(instruction_id[4:0]),
			.ex_reg_Rm					(ex_reg_Rm),
			.ex_mem_read				(ex_mem_read),
			.if_flush					(if_flush),
			.br_taken					(br_taken),
			.clk							(clk),
			.rst							(rst),
			.bubble_ctrl				(bubble_ctrl),
			.IF_ID_write				(IF_ID_write),
			.pc_write					(pc_write)

		);
		
	
	
	// ###################### reg file muxs ################################

	logic	r2l_or_BR;

	or #50 (r2l_or_BR, reg_to_loc, reg_br);

	//need to do reg_2_loc is also true for br_reg
	

	
	genvar i;
		generate
			for (i = 0; i < 5; i++) begin: sel_reg2_loc //mux for writeReg and read_reg_2
				mux2_1 reg2logic(
				
				.out	(read_reg_2[i]),
				.i0	(instruction_id[i+16]), 
				.i1	(instruction_id[i]),
				.sel	(r2l_or_BR)
				
				);
		end
	endgenerate
	


	
	
	// ###################### reg file ################################
	

	
	regfile regfilerun(
	
				.ReadData1			(read_data_1),
				.ReadData2			(read_data_2),
				.WriteData			(write_data),
				.ReadRegister1		(instruction_id[9:5]),
				.ReadRegister2		(read_reg_2),
				.WriteRegister		(wr_reg_addr),
				.RegWrite			(reg_write),
				.clk					(clk),
				.reset				(rst)
				
			);
		
	
							
	// ################# Control Unit ######################	//NEEDS Test, and probably moree....
	
	// READ Text book pg.301/302
	
	
						
	Control ctrl_unit(
	
					//inputs
					.clk				(clk),
					.rst				(rst),
					.instruction	(instruction_id[31:21]),	
					.bubble_ctrl	(bubble_ctrl),
					.Rd				(instruction_id[4:0]),

					//outputs
					.EX				(id_EX),
					.MEM				(id_MEM),
					.WB				(id_WB),
					.sel_se			(sel_se),
					.linked_br		(linked_br),
					.reg_br			(reg_br)
					
				); 
												
						
						
	//################## SE ###################### SHOULD ADD SHIFTING TO B AND CB???, NEEDS Test
	
	logic [63:0] 					se_data_temp;
	
	Sign_Extender se (
			
			.sel_se					(sel_se),
			.se_data					(se_data_temp),
			.instruction			(instruction_id)
			
			);
			
			
	//Need to check if is branch do this. 
	
	
	
	//#################### ID PC + BRANCH ###########################
	
	
	logic [63:0] 					br_shifted;
	logic [63:0]					br_link_data;
	

	
	buf #50 (br_shifted[0], 1'b0);
	buf #50 (br_shifted[1], 1'b0);

	genvar o;
		generate
			for (o = 2; o < 64; o++) begin: branchShift //shift branch addr
					buf #50 (br_shifted[o], se_data_temp[o-2]);
					
		end
	endgenerate	
	
	//need to se_data to be PC + 4 if were shifting 
	
	
	Adder PC_Add4(.A(pc_id), .B(64'h0000000000000004), .result(br_link_data));

	
	genvar f;
		generate
			for (f = 0; f < 64; f++) begin: se_data_shift_mux
			
			mux2_1 se_shift_muxs(
			
				.out(se_data[f]), 
				
				.i0(se_data_temp[f]), .i1(br_link_data[f]),
				
				.sel(linked_br));
				
			end
		endgenerate
			
	logic [63:0]		br_add_pc;
	
	Adder addPCandBr(.A(pc_id), .B(br_shifted), .result(br_add_pc));

	//Need mux for reg_br and pc_out
	// if (id_Rd == ex_Rd && EX/MEM ##############################
	
	//forward BR data or not
	
	logic [63:0] 					reg_br_data;
	
	genvar j;
		generate
			for (j = 0; j < 64; j++) begin: fwd_br_loop
			
			mux2_1 fwd_br_muxs(
			
				.out(reg_br_data[j]), 
				
				.i0(read_data_2[j]), .i1(forward_id_BR_data[j]),
				
				.sel(cbz_or_br));
				
			end
		endgenerate
		
	//BR or other branch
	
	genvar h;
		generate
			for (h = 0; h < 64; h++) begin: reg_br_or_addPCandBr
			
			mux2_1 reg_br_or_addPCandBr_muxs(
			
				.out(pc_out[h]), 
				
				.i0(br_add_pc[h]), .i1(reg_br_data[h]),
				
				.sel(reg_br));
				
			end
		endgenerate
		
	
	//================== Conditional Branch logic =====================
	
	logic [3:0]			flags_for_check;
	
	or #50 (cbz_or_br, sel_se.cbz_op, reg_br);
	
	genvar k;
		generate
			for (k = 0; k < 4; k++) begin: flag_mux_loop
				mux2_1 flagMux (
				
					.out (flags_for_check[k]),
					
					.i0  (flags[k]),
					
					.i1  (tempFlags[k]),
					
					.sel (ex_setFlags)
					
					);
				
			end
		endgenerate
		
	 Conditonal_Branch_Check conBrCheck(


			.read_data_1					(read_data_1),
			.read_data_2					(reg_br_data),
			.instruction					(instruction_id),
			.branch							(id_MEM.branch),
			.cbz_op							(sel_se.cbz_op),
			.blt_op							(sel_se.blt_op),
			.b_type							(sel_se.B_type),
			.flags							(flags_for_check),
			
			.br_taken						(br_taken)

		);
		
	

	//==================== Linked Br or Rd ========================
	
	
	//Need something to pass linked_br after shifting instead of se_data
	
	
	genvar t;
		generate
			for (t = 0; t < 4; t++) begin: wrRegMux 
				mux2_1 reg2logic_2(
				
				.out	(linked_or_Rd[t + 1]),
				.i0	(instruction_id[t + 1]),
				.i1	(1'b1),
				.sel	(linked_br)
				
				);	
		end
	endgenerate
	

	mux2_1 reg2logic(
	
				.out					(linked_or_Rd[0]),
				.i0					(instruction_id[0]),
				.i1					(1'b0),
				.sel					(linked_br)
	
			);	
	
	
endmodule 
						