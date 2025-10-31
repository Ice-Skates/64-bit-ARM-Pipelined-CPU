

module Forwarding_Unit (

		//inputs
		
		clk,
		rst,
		ex_Rn,
		ex_Rm,
		mem_Rd,
		wb_Rd,
		ex_mem_reg_write,
		mem_wb_reg_write,
		instruction_ex,
		
		
		
		//outputs
		
		forward_A,
		forward_B,
		
		//br inputs
		
		ALU_result,
		mem_ALU_result,
		wb_write_data,
		cbz_or_br,
		id_ex_reg_write,
		ex_Rd,
		
		forward_id_BR_data,
		forward_idB,
		id_Rd
		

	);
	
	
	
	input logic					clk, rst;
	input logic [4:0]	 		ex_Rn, ex_Rm;
	input logic [4:0] 		mem_Rd;
	input logic	[4:0]			wb_Rd;
	input logic 				ex_mem_reg_write;
	input logic 				mem_wb_reg_write;
	input logic	[31:0]		instruction_ex;
	
	output logic [1:0] 		forward_A;
	output logic [1:0] 		forward_B;
	
	//br logic
	input logic [63:0]		ALU_result;
	input logic [63:0]		mem_ALU_result;
	input logic [63:0]		wb_write_data;
	input logic 				cbz_or_br;
	input logic 				id_ex_reg_write;
	input logic [4:0]			ex_Rd;
	input logic	[4:0]			id_Rd;
	
	output logic [63:0]		forward_id_BR_data;
	output logic				forward_idB;

	logic [5:0] 				forward_rm;
	
	always_comb begin
	
		forward_A = '0;
		forward_B = '0;
		forward_idB = '0;
		forward_id_BR_data = '0;
		
		if (instruction_ex[31:21] == 11'b11111000000) begin //handle STUR
				
			forward_rm = instruction_ex[4:0];  // Rt field
			
		end
		
		else begin
		
			forward_rm = ex_Rm;
			
		end
	
		//############ br logic #############
		
		// need id_Rt,  ex_Rd, mem_Rd,  wb_Rd
		// ex_reg_write, mem_reg_write, wb_reg_write
		// ex_alu_result, mem_alu_result, wb_write_data
		// reg_br_op
		
		//output forward_id_BR_data, forward_id_BR
		
	
		
		if ( cbz_or_br & id_ex_reg_write & (ex_Rd == id_Rd)) begin
			 

				forward_idB = 1'b1;      				// from EX
				forward_id_BR_data =	 ALU_result;
				
			end

		if ( cbz_or_br & ex_mem_reg_write & (mem_Rd == id_Rd)) begin
		
				forward_idB = 1'b1;      					// from MEM
				forward_id_BR_data = mem_ALU_result;
				
			end

		
		if ( cbz_or_br & mem_wb_reg_write & (wb_Rd == id_Rd)) begin
		
				forward_idB = 1'b1;      					// from WB
				forward_id_BR_data = wb_write_data;
				
				
			end
	

		
		
		//Other logic
	
		if (ex_mem_reg_write & (mem_Rd != 5'd31)) begin
			
			if  (mem_Rd == ex_Rn) begin
				forward_A = 2'b10;			
			end
				
			if (mem_Rd == forward_rm) begin
				forward_B = 2'b10;   
			end
			
		end

			
		if (mem_wb_reg_write & (wb_Rd != 5'd31)) begin

			if  (wb_Rd == ex_Rn) begin
				forward_A = 2'b01;
			end
				
			if (wb_Rd == ex_Rm) begin
				forward_B = 2'b01;
			end
			
		end
	
		end
	
endmodule 