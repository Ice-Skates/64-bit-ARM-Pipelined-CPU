
import structures::*;

`timescale 1ps/1ps 


module Sign_Extender(sel_se, se_data, instruction);

	input  logic 			[31:0] instruction;
	input  format_type 	sel_se;
	output logic 			[63:0] se_data;
	
	
	logic [63:0] seImmData;
	logic [63:0] seLoadStore;
	logic [63:0] seBrAddr;
	logic [63:0] seCondBrAddr;	

	
	//Imm extend
	
	genvar i;
		generate 
			for (i = 0; i < 12; i++) begin: firstbits
				buf #50 se (seImmData[i], instruction[i+10]);
				
			end
		endgenerate
	
	genvar j;
		generate 
			for (j = 12; j < 64; j++) begin: extendedbits
				buf #50 se2 (seImmData[j], instruction[21]);
			end
		endgenerate
	
		
	//Load store extend
	
	genvar k;
		generate 
			for (k = 0; k < 9; k++) begin : seLS1
				buf #50 se (seLoadStore[k], instruction[12+k]);
			end
			
	genvar p;
			for (p = 9; p < 64; p++) begin : seLS2
				buf #50 se2 (seLoadStore[p], instruction[20]);   
			end
		endgenerate
	
	

	//brAddr extend
	genvar a;
		generate 
			for (a = 0; a < 26; a++) begin: seBr1
				buf #50 se (seBrAddr[a], instruction[a]);
			end
		endgenerate
	
	genvar b;
		generate 
			for (b = 26; b < 64; b++) begin: seBr2
				buf #50 se2 (seBrAddr[b], instruction[25]);
			end
		endgenerate
	
	
	//ConBrAddr extend
	genvar c;
		generate 
			for (c = 0; c < 18; c++) begin: seCondBr1
				buf #50 se (seCondBrAddr[c], instruction[c + 5]);
			end
		endgenerate
	
	genvar d;
		generate 
			for (d = 18; d < 64; d++) begin: seCondBr2
				buf #50 se2 (seCondBrAddr[d], instruction[23]);
			end
		endgenerate
		
	//This is like the worst way to this probably... boolean algebra go brrrr
		
	//Imm = D0, SL = D1, B = D2, CBZ = D3
	
	logic sel0, sel1;
	

	
   or #50 de4to2_1 (sel0, sel_se.D_type, sel_se.CB_type);
   or #50 de4to2_2 (sel1, sel_se.B_type, sel_se.CB_type);
	


		
	genvar e;
		generate
			for (e = 0; e < 64; e++) begin: se_data_muxs
			mux4_1 se_muxs(
			
				.out(se_data[e]), 
				
				.i00(seImmData[e]), .i01(seLoadStore[e]), .i10(seBrAddr[e]), .i11(seCondBrAddr[e]), 
				
				.sel0(sel0), .sel1(sel1));
			
		end
	endgenerate
	
endmodule 
	