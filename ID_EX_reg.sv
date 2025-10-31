
import structures::*; 

module ID_EX_reg(

			// inputs
			
			read_data_1,						
			read_data_2,			
			pc_id,						
			instruction_id,			
			id_EX,						
			id_MEM,					
			id_WB,						
			se_data,					
			Rm_if_id,					
			Rn_if_id,					
//			Rd_if_id,	
			clk,
			rst,
			linked_or_Rd,
			
			// outputs
			
			pc_ex,						
			instruction_ALU_ctrl,		
			read_data_1_ex,			
			read_data_2_ex,			
			ex_Rm, ex_Rn,
			ex_Rd,
			ex_EX,						
			ex_MEM,						
			ex_WB,
			instruction_ex,
			se_data_ex

		);
		
	//inputs
	
	input logic [63:0] 	read_data_1, read_data_2, pc_id;
	input logic [31:0] 	instruction_id;
	
	input struct_EX	 	id_EX;	
	input struct_MEM	 	id_MEM;		
	input struct_WB		id_WB;
	
	input logic [63:0]	se_data;
	
	input logic [4:0]		Rm_if_id;
	input logic [4:0]		Rn_if_id;

	input logic [4:0]		linked_or_Rd;
	
	input logic 			clk,rst;
	
	//outputs
	
	output logic [63:0] 	read_data_1_ex, read_data_2_ex, pc_ex, se_data_ex;
	output logic [10:0]	instruction_ALU_ctrl;
	output logic [31:0] 	instruction_ex;
	

	output struct_EX	 	ex_EX;	
	output struct_MEM	 	ex_MEM;		
	output struct_WB		ex_WB;
	
	output logic [4:0]  ex_Rm, ex_Rn;
	
	output logic [4:0]  ex_Rd;
	
	
	genvar s;
		generate			
			for(s = 0; s < 11; s++) begin : alu_ctrl_loop
				singleReg alu_ctrl_reg(.enable(1'b1), .writeData(instruction_id[s+21]), .reset(rst),
												  .clk(clk), .out(instruction_ALU_ctrl[s]));
			end	
	endgenerate		
	
	genvar h;
		generate			
			for(h = 0; h < 5; h++) begin : rd_reg_loop
				singleReg rd_reg(.enable(1'b1), .writeData(linked_or_Rd[h]), .reset(rst),
												  .clk(clk), .out(ex_Rd[h]));
			end	
	endgenerate		

	genvar g;
		generate			
			for(g = 0; g < 5; g++) begin : rn_reg_loop
				singleReg rn_reg(.enable(1'b1), .writeData(Rn_if_id[g]), .reset(rst),
												  .clk(clk), .out(ex_Rn[g]));
			end	
	endgenerate		
	
	genvar f;
		generate			
			for(f = 0; f < 5; f++) begin : Rm_reg_loop
				singleReg Rm_reg(.enable(1'b1), .writeData(Rm_if_id[f]), .reset(rst),
												  .clk(clk), .out(ex_Rm[f]));
			end	
	endgenerate		
//	
	genvar e;
		generate			
			for(e = 0; e < 32; e++) begin : instruction_reg_loop
				singleReg instruction_reg(.enable(1'b1), .writeData(instruction_id[e]), .reset(rst),
												  .clk(clk), .out(instruction_ex[e]));
			end	
	endgenerate	
	
	

	genvar d;
		generate			
			for(d = 0; d < 64; d++) begin : se_data_reg_loop
				singleReg read_data_1_reg(.enable(1'b1), .writeData(se_data[d]), .reset(rst),
												  .clk(clk), .out(se_data_ex[d]));
			end	
	endgenerate	
	
	

	genvar c;
		generate			
			for(c = 0; c < 2; c++) begin : wb_reg_loop
				singleReg wb_reg(.enable(1'b1), .writeData(id_WB[c]), .reset(rst),
												  .clk(clk), .out(ex_WB[c]));
			end	
	endgenerate	
	
	
	genvar b;
		generate			
			for(b = 0; b < 5; b++) begin : mem_reg_loop
				singleReg mem_reg(.enable(1'b1), .writeData(id_MEM[b]), .reset(rst),
												  .clk(clk), .out(ex_MEM[b]));
			end	
	endgenerate	
	

	
	genvar a;
		generate			
			for(a = 0; a < 4; a++) begin : ex_reg_loop
				singleReg ex_reg(.enable(1'b1), .writeData(id_EX[a]), .reset(rst),
												  .clk(clk), .out(ex_EX[a]));
			end	
	endgenerate	
	

	

	genvar y;
		generate			
			for(y = 0; y < 64; y++) begin : read_data_1_reg
				singleReg read_data_1_reg(.enable(1'b1), .writeData(read_data_1[y]), .reset(rst),
												  .clk(clk), .out(read_data_1_ex[y]));
			end	
	endgenerate	
	
	
	genvar x;
		generate			
			for(x = 0; x < 64; x++) begin : read_data_2_reg
				singleReg read_data_2_reg(.enable(1'b1), .writeData(read_data_2[x]), .reset(rst),
												  .clk(clk), .out(read_data_2_ex[x]));
			end	
	endgenerate	
	
	
	genvar u;
		generate			
			for(u = 0; u < 64; u++) begin : pc_reg_loop
				singleReg pc_reg(.enable(1'b1), .writeData(pc_id[u]), .reset(rst),
												  .clk(clk), .out(pc_ex[u]));
			end	
	endgenerate	
	
	
	
//	genvar z;
//		generate			
//			for(z = 0; z < 32; z++) begin : instruct_reg
//				singleReg instruct_reg(.enable(1'b1), .writeData(instruction_in[z]), .reset(rst),
//												  .clk(clk), .out(instruction_out[z]));
//			end	
//	endgenerate	
//	
//	
	
	
endmodule
	