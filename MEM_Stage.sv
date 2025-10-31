
import structures::*;

`timescale 1ps/1ps 

module MEM_Stage(



		//inputs

		//.if_pc_src				(if_pc_src),			//####
		mem_MEM,					
		mem_WB,					
		mem_flags,				
		mem_ALU_result,	
		mem_ALU_B,		
		mem_Rd,	
		//mem_pc_br_data,
		clk,
		rst,

		//outputs
		
		mem_read_data
		//if_pc_src				


	);
	
	
	
	
	
	//input logic [63:0] 		mem_pc_br_data;
	input logic [3:0]			mem_flags;
	input logic [63:0]		mem_ALU_result;
	input logic [63:0]		mem_ALU_B;
	input logic [4:0]			mem_Rd;
	input logic 				clk, rst;
	input struct_MEM			mem_MEM;
	input struct_WB			mem_WB;
	
	//output logic 				if_pc_src; //PCSrc going to IF mux
	output logic [63:0]		mem_read_data;
	
	
	
	
	
	
	//and #50 pc_src (if_pc_src, mem_flags[1], mem_MEM.branch); //Branch and zero flag
	
	
	
	datamem runDataMem( 
	
				.address(mem_ALU_result), 
				.write_enable(mem_MEM.mem_write), 
				.read_enable(mem_MEM.mem_read), 
				.write_data(mem_ALU_B),
				.clk(clk),
				.xfer_size(4'd8),
				.read_data(mem_read_data)
				
			);
						
						
endmodule 


//	logic [63:0] memReadData;
	
//	
//	genvar y;
//		generate
//			for(y = 0; y < 64; y++) begin: MemtoReg_mux
//				mux4_1 memRead_ALU_mux(.out(wrData[y]), .i00(ALUresult[y]), .i01(memReadData[y]), 
//									.i10(pcAdd4[y]), .i11(1'b0), .sel0(MemtoReg), .sel1(LinkBr));
//									
//		end
//	endgenerate
//		
//	datamem runDataMem( .address(ALUresult), .write_enable(MemWrite), .read_enable(MemRead), 
//						.write_data(readData2), .clk(clk), .xfer_size(4'd8), .read_data(memReadData));
//						