//Nate Snyder, CSE 469 Project 3, Single-Cycle ARM CPU,

`timescale 1ps/1ps



import structures::*;


module armCPU_Pipelined (clk, rst);

	input logic clk, rst;
	

// IF Stage logic

	logic 		 			if_pc_src;
	logic [63:0]			pc_br;
	logic [63:0]			IF_ID_pc; 
	logic						pc_write;
	logic 					if_flush;


	//logic [63:0]			mem_pc_br_data; 
	

// IF/ID register logic

	
	logic [31:0] 			instruction_if; 		//instruction from PC to IF/ID reg
	logic [31:0] 			instruction_id; 		//instruction out of IF/ID reg
	
// ID Stage logic

	logic 					bubble_ctrl;
	logic						IF_ID_write;			//These 3 are hazard detection
	logic						PC_write;
	logic						br_taken;


	logic [63:0] 			read_data_1, read_data_2;
	logic [63:0] 			id_write_data;
	logic [63:0] 			se_data;
	logic [4:0] 			id_write_reg;
	logic						id_reg_wr;	
	logic [4:0]				linked_or_Rd;
	logic [63:0]			pc_out;
	logic [63:0]			pc_id;

	
	struct_EX 	 			id_EX;  
	struct_MEM 	 			id_MEM; 
	struct_WB	 			id_WB; 	

	
// ID/EX register logic

	logic [63:0]			pc_ex;
	logic [10:0] 			instruction_ALU_ctrl;
	logic [63:0] 			read_data_1_ex, read_data_2_ex;
	logic [63:0]			se_data_ex;
	logic [31:0]			instruction_ex;
	logic [4:0]	 			ex_Rd, ex_Rn, ex_Rm;

	struct_EX 				ex_EX;  						//	ALU_src, ALU_op
	struct_MEM 				ex_MEM; 						//	brTaken, zeroflag, memWrite, PCSrc, memRead
	struct_WB				ex_WB;  						//	RegWrite, Mem2Reg
	

//	EX Stage logic


	logic [3:0]				flags;
	//logic [63:0]			pc_br_data;			//#####################
	logic [63:0] 			ALU_result;
	logic [63:0]			ALU_B;
	logic [3:0]				tempFlags;



//	EX/MEM register logic

	logic [3:0] 			mem_flags;	
	logic	[63:0]			mem_ALU_result;
	logic [4:0]				mem_Rd;
	logic [63:0]			mem_ALU_B;
	
	struct_MEM 				mem_MEM; 
	struct_WB				mem_WB; 	


//	MEM Stage logic

	logic	[63:0]			mem_read_data;

//	MEM/WB register logic

	logic	[63:0]			wb_read_data;
	logic	[63:0]			wb_ALU_result;
	logic [4:0]				wb_Rd;
	
	struct_WB				wb_WB;

		

//		WB Stage logic


	
	
// ########################## IF STAGE & PC #############################





	IF_Stage  if_Stage(
	
					 .pc_src							(br_taken), 
					 .pc_br							(pc_br),
					 .pc_write						(pc_write), 
					 .clk								(clk), 
					 .rst								(rst), 
					 
					 //outputs
					 .pc								(IF_ID_pc),
					 .instruction					(instruction_if)
							 
							 
			); 
	
	
	
	
// ######################### IF/ID REGISTER #############################

	IF_ID_reg if_id_register (
	
					 .instruction_in			(instruction_if), 
					 .pc_in						(IF_ID_pc),
					 .IF_ID_write				(IF_ID_write), 
					 .if_flush					(if_flush),
					 .clk							(clk),
					 .rst							(rst),
					 
					 .pc_out						(pc_id),
					 .instruction_out			(instruction_id) 
					 
			); 
	
	
	
	
	
// ######################### ID STAGE & CONTROL UNIT #############################


	logic 				cbz_or_br;
	logic [63:0]		forward_id_BR_data;
	logic					forward_idB;
	
	ID_Stage  id_stage (
	
					//Hazard detection
				 
					.ex_reg_Rm					(ex_Rm),
					.ex_mem_read				(ex_MEM.mem_read),
					.bubble_ctrl				(bubble_ctrl),
					.IF_ID_write				(IF_ID_write),
					.pc_write					(pc_write),
					
					//inputs

					.clk							(clk), 
					.rst							(rst),
					.instruction_id			(instruction_id), 
					.reg_to_loc					(instruction_id[28]),
					.write_data					(id_write_data),
					.wr_reg_addr				(id_write_reg),
					.reg_write					(id_reg_wr),
					.pc_id						(pc_id),
					.flags						(flags),
					.tempFlags					(tempFlags),
					.ex_setFlags				(ex_EX.setFlags),
					
					//outputs
					
					.se_data						(se_data),
					.read_data_1				(read_data_1), 
					.read_data_2				(read_data_2),
					.id_EX						(id_EX), 
					.id_MEM						(id_MEM), 
					.id_WB						(id_WB),
					.linked_or_Rd				(linked_or_Rd),
					.pc_out						(pc_br),
					.br_taken					(br_taken),
					.if_flush					(if_flush),
					
					
					//CBZ/BR logic
					
					
					.cbz_or_br					(cbz_or_br), //
					.forward_id_BR_data		(forward_id_BR_data), //input
					.forward_idB				(forward_idB)			 //input

				 
			 );
							 							

// ######################### ID/EX REGISTER	##########################


	

	
	ID_EX_reg id_ex_reg (
	
				// inputs
				
				.read_data_1				(read_data_1), 		
				.read_data_2				(read_data_2), 
				.pc_id						(pc_id), 										//#####################
				.instruction_id			(instruction_id),
				.id_EX						(id_EX), 
				.id_MEM						(id_MEM), 
				.id_WB						(id_WB), 
				.se_data						(se_data),
				.Rm_if_id					(instruction_id[20:16]), 		
				.Rn_if_id					(instruction_id[9:5]), 		
				.linked_or_Rd				(linked_or_Rd), 
				.clk							(clk),
				.rst							(rst),
				
				
				// outputs
				
				.pc_ex						(pc_ex), 							//#####################
				.instruction_ALU_ctrl	(instruction_ALU_ctrl), 				
				.read_data_1_ex			(read_data_1_ex), 
				.read_data_2_ex			(read_data_2_ex),
				.se_data_ex					(se_data_ex),	
				.ex_Rm						(ex_Rm),
				.ex_Rn						(ex_Rn),
				.ex_Rd						(ex_Rd),
				.ex_EX						(ex_EX), 
				.ex_MEM						(ex_MEM), 
				.ex_WB						(ex_WB),
				.instruction_ex			(instruction_ex)
				
				
			);
							
							
							
// ######################### EX STAGE & ALU #############################



	
	EX_Stage ex_stage(
	 
				//inputs
				.ex_EX						(ex_EX),
				.ex_MEM						(ex_MEM),
				.ex_WB						(ex_WB),
				.read_data_1_ex			(read_data_1_ex),
				.read_data_2_ex			(read_data_2_ex),
				.se_data_ex					(se_data_ex),
				.instruction_ALU_ctrl	(instruction_ALU_ctrl),
				.clk							(clk),
				.rst							(rst),
				
				//forwarding unit inputs
				
				.ex_Rm						(ex_Rm),
				.ex_Rn						(ex_Rn),
				.mem_Rd						(mem_Rd),
				.wb_Rd						(wb_Rd),
				.ex_mem_reg_write			(mem_WB.reg_write),
				.mem_wb_reg_write			(wb_WB.reg_write),
				.id_write_data				(id_write_data),
				.mem_ALU_result			(mem_ALU_result),
				.instruction_ex			(instruction_ex),
				
				
				//outputs
				.flags						(flags),
				.tempFlags					(tempFlags),
				.ALU_B						(ALU_B),
				.ALU_result					(ALU_result),
				
				//Br logic
				
				.cbz_or_br					(cbz_or_br),
				.forward_id_BR_data		(forward_id_BR_data),
				.forward_idB				(forward_idB),
				.id_Rd						(instruction_id[4:0]),
				.ex_Rd						(ex_Rd)

	
	); 

// ################# EX/MEM ######################


	EX_MEM_reg ex_mem_reg(
	
			//inputs
			
			//.pc_br_data				(pc_br_data),						//#####################
			.ALU_result				(ALU_result),
			.flags					(flags),
			.ex_MEM					(ex_MEM),
			.ex_WB					(ex_WB),
			.ex_Rd					(ex_Rd),
			.ALU_B					(ALU_B),
			.clk						(clk),
			.rst						(rst),

			//outputs 
			.mem_MEM					(mem_MEM),
			.mem_WB					(mem_WB),
			.mem_flags				(mem_flags),
			.mem_ALU_result		(mem_ALU_result),
			.mem_ALU_B				(mem_ALU_B),
			.mem_Rd					(mem_Rd)
			//.mem_pc_br_data		(mem_pc_br_data)							//pc_br goes to IF
			
		);


// ################# MEM ######################

	
	
	
	MEM_Stage mem_stage(
	
			//inputs
	
			.mem_MEM					(mem_MEM),
			.mem_WB					(mem_WB),
			.mem_flags				(mem_flags),
			.mem_ALU_result		(mem_ALU_result),
			.mem_ALU_B				(mem_ALU_B),
			.mem_Rd					(mem_Rd),
			//.mem_pc_br_data		(mem_pc_br_data),					//#####################
			.clk						(clk),
			.rst						(rst),
			
			//outputs
			
			.mem_read_data			(mem_read_data)
			//.if_pc_src				(if_pc_src)							//#####################


	);



// ################# MEM/WB ######################




	MEM_WB_reg mem_wb_register(
	
			//inputs
	
			.mem_read_data			(mem_read_data),
			.mem_ALU_result		(mem_ALU_result),
			.mem_WB					(mem_WB),
			.mem_Rd					(mem_Rd),
			.clk						(clk),
			.rst						(rst),

			
			//outputs
			.wb_read_data			(wb_read_data),
			.wb_ALU_result			(wb_ALU_result),
			.wb_Rd					(wb_Rd),					//goes directly to id write register
			.wb_WB					(wb_WB)
			

	);
	
	
// ################# WB STAGE ######################


	
	

	
	WB_Stage write_back_stage(
	
			//inputs
			
			.wb_read_data			(wb_read_data),
			.wb_ALU_result			(wb_ALU_result),
			.wb_Rd					(wb_Rd),
			.wb_WB					(wb_WB),
			.clk						(clk),
			.rst						(rst),			

			//outputs
			
			.id_write_data			(id_write_data),			//######### check the outputs 
			.id_write_reg			(id_write_reg),			
			.id_reg_write			(id_reg_wr)
			
		);
	
	
// ===================== END =======================

	
endmodule
			  
			  

			  
			  

module armCPU_Pipelined_testbench(); //testbench

	parameter ClockDelay = 10000;
	logic clk, rst;

	armCPU_Pipelined dut (.clk(clk), .rst(rst));	
		
		initial begin
		
			clk = 0;
			
			forever #(ClockDelay/2) clk = ~clk;
		
		end

	
		initial begin
		
			rst = 1;

			#(ClockDelay);
					
			rst  = 0;

			repeat (200) @(posedge clk);		

		$stop;
				
	end
	
endmodule
	
	
