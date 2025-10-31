`timescale 1ps/1ps


module regfile (ReadData1, ReadData2, WriteData, ReadRegister1, ReadRegister2, WriteRegister, 
					RegWrite, clk, reset);

			
		input logic	[4:0]		ReadRegister1, ReadRegister2, WriteRegister;
		input logic [63:0]	WriteData;
		input logic				RegWrite, clk, reset;
		output logic [63:0]	ReadData1, ReadData2;
		
		logic [31:0] writeEnable;
		logic [15:0] secondDecoderOut;
		logic [3:0] out2to4; 
		
		logic [31:0][63:0] registers;
		

		
		and #50 de2to4_1   (out2to4[0], ~WriteRegister[3], ~WriteRegister[4], RegWrite);
		and #50 de2to4_2   (out2to4[1], WriteRegister[3], ~WriteRegister[4], RegWrite);
		and #50 de2to4_3   (out2to4[2], ~WriteRegister[3], WriteRegister[4], RegWrite);
		and #50 de2to4_4   (out2to4[3], WriteRegister[3], WriteRegister[4], RegWrite);
				
		
	
		enDecoder3_8 dec3_8_1 (.enable(out2to4[0]), .in({WriteRegister[2], WriteRegister[1], WriteRegister[0]}), 
									.out(writeEnable[7:0]));
									
		enDecoder3_8 dec3_8_2 (.enable(out2to4[1]), .in({WriteRegister[2], WriteRegister[1], WriteRegister[0]}), 
									  .out(writeEnable[15:8]));
								  
		enDecoder3_8 dec3_8_3 (.enable(out2to4[2]), .in({WriteRegister[2], WriteRegister[1], WriteRegister[0]}), 
									  .out(writeEnable[23:16]));
									  
		enDecoder3_8 dec3_8_4 (.enable(out2to4[3]), .in({WriteRegister[2], WriteRegister[1], WriteRegister[0]}), 
									  .out(writeEnable[31:24]));
									  
			

		genvar n;
		genvar m;
		
		
			generate 
			
				for(m = 0; m < 31; m++) begin : regs		
				
						for(n = 0; n < 64; n++) begin : DFFs
											
							singleReg writetoregister(.enable(writeEnable[m]), .writeData(WriteData[n]), .reset(reset),
												  .clk(clk), .out(registers[m][n]));
												  						
												  
							end					  
				end
		endgenerate
					
		
		genvar c;
			generate
				for (c = 0; c < 64; c++) begin : reg31
				
					singleReg writetoregister(.enable(writeEnable[31]), .writeData(1'b0), .reset(reset),
						.clk(clk), .out(registers[31][c]));
						
				end
				
		endgenerate 
				
		
		logic [63:0] reg_data_1, reg_data_2;
		
		genvar i;
		
			generate
			
			
				for(i=0; i < 64; i++) begin : eachReg
				
					logic [31:0] temp_bits;
				
					genvar j;
        
					for(j=0; j<32; j++) begin: storetemp
				
						
						assign temp_bits[j] = registers[j][i];
					
					end
				
					mux32_1 mux32_1_1(.registers(temp_bits), .ReadRegister(ReadRegister1),
											.out(reg_data_1[i]));
											
											
											
					mux32_1 mux32_1_2(.registers(temp_bits), .ReadRegister(ReadRegister2),
											.out(reg_data_2[i]));
					
				end

		endgenerate
		
	//	Everything below is making sure that reading a register that is being written to
	//		during the same clock cycle returns the write data, added during project 4
	
	logic [4:0] 			match_addr_1, match_addr_2;
	logic 					hold_1, hold_2;					
	logic 					match_1, match_2;

	
	genvar q;
		generate
			for(q = 0; q < 5; q++) begin: check_addr
				xnor #50 xnor1(match_addr_1[q], WriteRegister[q], ReadRegister1[q]);
				xnor #50 xnor2(match_addr_2[q], WriteRegister[q], ReadRegister2[q]);
				
		end
	endgenerate


	
	and  #50 and_1			(hold_1, match_addr_1[0], match_addr_1[1], match_addr_1[2]);
	and  #50 and_1_2		(match_1, hold_1, match_addr_1[3], match_addr_1[4], RegWrite);				
	and  #50 and_2			(hold_2, match_addr_2[0], match_addr_2[1], match_addr_2[2]);
	and  #50 and_2_2		(match_2, hold_2, match_addr_2[3], match_addr_2[4], RegWrite);
	

	genvar p;
		generate
			for (p = 0; p < 64; p++) begin: match_write_read_addr 
				mux2_1 addr_1(
				
				.out	(ReadData1[p]),
				.i0	(reg_data_1[p]), 
				.i1	(WriteData[p]),
				.sel	(match_1)
				
				);
				mux2_1 addr_2(
				
				.out	(ReadData2[p]),
				.i0	(reg_data_2[p]), 
				.i1	(WriteData[p]),
				.sel	(match_2)
				
				);
		end
	endgenerate
		
endmodule
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	





