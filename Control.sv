	


`timescale 1ps/1ps

import structures::*; 


module Control(

					clk,
					rst,
					instruction, 
					bubble_ctrl,
					Rd,
					EX, 
					MEM, 
					WB, 
					sel_se,
					linked_br,
					reg_br
					 
				);

	input logic 			clk;
	input logic 			rst;
	input logic 			[10:0] instruction;
	input logic 			bubble_ctrl;
	input logic 			[4:0] Rd;
	output format_type 	sel_se;					
	
	output struct_EX 	EX; 	//	ALU_src, ALU_op
	output struct_MEM	MEM; 	//	brTaken, zeroflag, memWrite, PCSrc, memRead
	output struct_WB	WB; 	//	RegWrite, Mem2Reg	
	output logic		linked_br;	
	output logic		reg_br;	

	
	//B 		2'b00
	//ADD		2'b01
	//SUB		2'b10
	//other	2'b11

	
//	typedef enum logic [10:0] {
//	
//		ADDI	= 11'b1001000100x;
//		ADDS	= 11'b10101011000;			//Cant have x's
//		SUBS	= 11'b11101011000;
//		B		= 11'b000101xxxxx; 
//		BL		= 11'b100101xxxxx;
//		BR 	= 11'b11010110000;
//		CBZ	= 11'b10110100xxx;
//		B.LT	= 11'b01010100xxx;
//		LDUR	= 11'b11111000010;
//		STUR	= 11'b11111000000;
//		
//	}	instruction_type_opcodes;
	
	always_comb begin
	
		EX  			= '0;
		MEM 			= '0;
		WB	 			= '0;
		sel_se		= '0;
		linked_br	= '0;
		reg_br		= '0;

		
		if (bubble_ctrl == '1) begin
		
			
			EX  			= '0;
			MEM 			= '0;
			WB	 			= '0;
			sel_se		= '0;
			linked_br	= '0;
			reg_br		= '0;
			
			end
			
				
	
		else if 		(instruction[10:1] == 11'b1001000100) begin		//ADDI
		
			EX.ALU_src 		= 1'b1;
			EX.ALU_op		= 2'b01;
			WB.reg_write 	= 1'b1;
			sel_se.I_type 	= 1'b1;
			
			end
	
		else if 	(instruction[10:0] == 11'b10101011000) begin		//ADDS
		
			EX.ALU_op		= 2'b01;
			WB.reg_write 	= 1'b1;
			EX.setFlags = 1'b1;
			
			end
		
		else if 	(instruction[10:0] == 11'b11101011000) begin		//SUBS
		
			EX.ALU_op		= 2'b10;
			WB.reg_write = 1'b1;
			EX.setFlags = 1'b1;

			end
		
		else if 	(instruction[10:5] == 6'b000101) begin				//B
		
			EX.ALU_op		= 2'b00;
			MEM.branch 		= 1'b1;
			sel_se.B_type 	= 1'b1;
			
			end
		
		else if 	(instruction[10:5] == 6'b100101) begin				//BL
		
		
			EX.ALU_op		= 2'b00;
			EX.ALU_src 		= 1'b1;
			WB.reg_write 	= 1'b1;
			MEM.branch 		= 1'b1;
			sel_se.B_type 	= 1'b1;
			linked_br		= 1'b1;


			
			end


		else if 	(instruction[10:0] == 11'b11010110000) begin		//BR
		
			EX.ALU_op		= 2'b00;
			sel_se.B_type 	= 1'b1;
			reg_br		= 1'b1;

			MEM.branch = 1'b1;
			
			end

		
		else if 	(instruction[10:3] == 8'b10110100) begin			//CBZ
		
			EX.ALU_op		= 2'b00;
			MEM.branch = 1'b1;
			//reg_br		= 1'b1;
			//setFlags = 1'b1;
			sel_se.CB_type 	= 1'b1;
			sel_se.cbz_op		= 1'b1;



			end

		
		
		else if 	(instruction[10:3] == 8'b01010100) begin			//B.LT

			EX.ALU_src 			= 1'b1;
			EX.ALU_op			= 2'b10;
			MEM.branch 			= 1'b1;
			sel_se.CB_type 	= 1'b1;
			sel_se.blt_op		= 1'b1;
			

			end



		
		else if 	(instruction[10:0] == 11'b11111000010) begin		//LDUR
		
			EX.ALU_op		= 2'b01;
		
			WB.reg_write  		= 1'b1;
			WB.mem_to_reg 		= 1'b1;
			MEM.mem_read  		= 1'b1;
			sel_se.D_type 		= 1'b1;
			EX.ALU_src 			= 1'b1;


			end
		
		else if 	(instruction[10:0] == 11'b11111000000) begin		//STUR
		
		
			EX.ALU_op		= 2'b01;
			MEM.mem_write	= 1'b1;
			sel_se.D_type 	= 1'b1;
			EX.ALU_src 			= 1'b1;

		
		end
		
		if (Rd == 5'b11111) begin
		
			WB.reg_write  		= 1'b0;
			
		end

		
		
	end
		
endmodule
		
	
	
	/*
	
		Op codes:
	
	ADDI: 100 1000 100x
	ADDS: 111 0101 0000
	SUBS: 111 0101 1000

	
	B: 	000 101x xxxx
	BL: 	100 101x xxxx
	
	BR: 	110 1011 0000
	CBZ: 	101 1010 0xxx
	
	B.LT: 101 001x xxxx
	
	LDUR: 111 1100 0010
	STUR: 111 1100 0000
	
	*/
	
	
	
module Control_testbench();	

	parameter ClockDelay = 200;


	logic 			clk;
	logic 			rst;
	logic 			[10:0] instruction;
	format_type 	sel_se;					
	
	struct_EX 	EX; 	
	struct_MEM	MEM; 	
	struct_WB	WB; 	
	logic		linked_br;	
	

	Control ctrl(
					clk,
					rst,
					instruction, 
					EX, 
					MEM, 
					WB, 
					sel_se,
					linked_br
					
			);
				
	initial begin
	
	$display("test works!");
		
		clk <= 0;
		forever #(ClockDelay/2) clk <= ~clk;
		
	end
	

	
		initial begin
		
		rst = 1;
		
		#ClockDelay;

		rst  = 0;

		#ClockDelay;
		
		instruction = 11'b00000000000;
		
		#ClockDelay;
		
		instruction = 11'b10010001000;

		#ClockDelay;
		
		instruction = 11'b10010001001;
		
		#ClockDelay;
		
		instruction = 11'b00010110001;
		
		#ClockDelay;
		
		instruction = 11'b00010110001;

				#ClockDelay;

				#ClockDelay;
				
				#ClockDelay;
				#ClockDelay;
				#ClockDelay;
				#ClockDelay;
				#ClockDelay;
				#ClockDelay;
				#ClockDelay;


		
		$stop;
		
	end
	
endmodule
		
	