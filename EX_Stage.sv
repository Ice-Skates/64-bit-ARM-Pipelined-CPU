import structures::*; 
`timescale 1ps/1ps 


module EX_Stage(

		instruction_ALU_ctrl,		
		read_data_1_ex,			
		read_data_2_ex,			
		ex_Rm,
		ex_Rn,
		ex_EX,						
		ex_MEM,						
		ex_WB,
		instruction_ex,
		se_data_ex,
		clk,
		rst,
		mem_Rd,
		wb_Rd,
		ex_mem_reg_write,
		mem_wb_reg_write,
		id_write_data,				
		mem_ALU_result,	
		

		ALU_result,
		ALU_B,
		flags,
		tempFlags,
		
		cbz_or_br,				
		forward_id_BR_data,	
		forward_idB,			
		id_Rd,					
		ex_Rd					

	);
	
	
	
	
	input logic [63:0] 		se_data_ex;
	input logic [63:0] 		read_data_1_ex, read_data_2_ex;
	input logic [10:0] 		instruction_ALU_ctrl;	
	input logic					clk, rst;
	
	input struct_EX	 		ex_EX;	
	input struct_MEM	 		ex_MEM;		
	input struct_WB	 		ex_WB;
	
	input logic [63:0] 		id_write_data;
	input logic [63:0] 		mem_ALU_result;			
	
	output logic [3:0]		flags;
	output logic [63:0] 		ALU_result;



	//#### forwarding unit stuff
	
	input logic [4:0]	 		ex_Rn, ex_Rm, ex_Rd;
	input logic [4:0] 		mem_Rd;
	input logic	[4:0]			wb_Rd;
	input logic 				ex_mem_reg_write;
	input logic 				mem_wb_reg_write;
	
	logic [1:0] 				forward_A;
	logic [1:0] 				forward_B;
	
	
	input logic 				cbz_or_br;
	input logic	 [4:0]		id_Rd;
	output logic [63:0]		forward_id_BR_data;
	output logic				forward_idB;
	
	input logic [31:0]		instruction_ex;



	Forwarding_Unit ForwardUnit (
	
		//inputs
		.clk						(clk),
		.rst						(rst),
		.ex_Rn					(ex_Rn),
		.ex_Rm					(ex_Rm),
		.mem_Rd					(mem_Rd),
		.wb_Rd					(wb_Rd),
		.ex_mem_reg_write		(ex_mem_reg_write),			//these need to be the WB signals
		.mem_wb_reg_write		(mem_wb_reg_write),
		.instruction_ex		(instruction_ex),
		
		//outputs
		
		.forward_A				(forward_A),
		.forward_B				(forward_B),
		
		//BR stuff
		
		.forward_id_BR_data	(forward_id_BR_data),
		.forward_idB			(forward_idB),
		
		.ALU_result				(ALU_result),
		.mem_ALU_result		(mem_ALU_result),
		.wb_write_data			(id_write_data),
		
		.cbz_or_br				(cbz_or_br),
		.id_ex_reg_write		(ex_WB.reg_write),
		.ex_Rd					(ex_Rd),
		.id_Rd					(id_Rd)
		
	
	);
	
	
	
	
	
//	============== ALU ==============
	
	

	logic [2:0]	 ALU_ctrl;
	
	ALU_ctrl alu_control_unit(
	
		.instruction_ALU_ctrl			(instruction_ALU_ctrl), 
		.ALU_op								(ex_EX.ALU_op),
		.ALU_ctrl							(ALU_ctrl)
		
	
		);
		

	

	
	logic [63:0] 				ALU_A;
	output logic [63:0]		ALU_B;	//needed for reg write data

	
	genvar z;
		generate 
			for (z = 0; z < 64; z++) begin: ALU_A_loop
				mux4_1 ALU_A_mux(
				
				.out(ALU_A[z]), 
				.i00(read_data_1_ex[z]), 
				.i01(id_write_data[z]),
				.i10(mem_ALU_result[z]),
				.i11(1'b0),
				.sel0(forward_A[0]),
				.sel1(forward_A[1])

				
				);
				
		end
	endgenerate
	
	genvar y;
		generate 
			for (y = 0; y < 64; y++) begin: ALU_B_loop
				mux4_1 ALU_B_mux(
				
				.out(ALU_B[y]), 
				.i00(read_data_2_ex[y]), 
				.i01(id_write_data[y]),
				.i10(mem_ALU_result[y]),
				.i11(1'b0),
				.sel0(forward_B[0]),
				.sel1(forward_B[1])

				
				);
				
		end
	endgenerate
	
	
	logic [63:0] se_or_B;
	
	genvar n;
		generate 
			for (n = 0; n < 64; n++) begin: SignE_readData2_muxs 
				mux2_1 se_or_read2_mux(
				
				.out(se_or_B[n]), 
				.i0(ALU_B[n]), 
				.i1(se_data_ex[n]), 
				.sel(ex_EX.ALU_src)
				
				);
				
		end
	endgenerate

	output logic  [3:0] tempFlags;				
	
	alu runALU(.A(ALU_A), .B(se_or_B), .cntrl(ALU_ctrl), .result(ALU_result),
			  .negative(tempFlags[0]), .zero(tempFlags[1]),
			  .overflow(tempFlags[2]), .carry_out(tempFlags[3]));
			  
			  
	singleReg negativeReg(.enable(ex_EX.setFlags), .writeData(tempFlags[0]), .reset(rst),
									.clk(clk), .out(flags[0]));

	singleReg zeroReg(.enable(ex_EX.setFlags), .writeData(tempFlags[1]), .reset(rst),
									.clk(clk), .out(flags[1]));
									
	singleReg overflowReg(.enable(ex_EX.setFlags), .writeData(tempFlags[2]), .reset(rst),
									.clk(clk), .out(flags[2]));

	singleReg carryReg(.enable(ex_EX.setFlags), .writeData(tempFlags[3]), .reset(rst),
									.clk(clk), .out(flags[3]));
	
	
	
	
endmodule 
	
	

