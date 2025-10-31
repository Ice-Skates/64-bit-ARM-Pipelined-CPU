`timescale 1ps/1ps


module outputXor(A, B, negative, zero, overflow, carry_out, result);

	input logic [63:0] A, B;
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	
	genvar i;
	
		generate
		
			for(i = 0; i < 64; i++) begin: write
			
				xor #50 writeToResult (result[i], A[i], B[i]);
				
			end
			
		endgenerate
		
	
	buf #50 writeNegative(negative, result[63]);
	
	checkZero checkZeroB(result, zero);
	
	buf #50 writeOverflow(overflow, 1'b0); //Set overflow and carry_out to zero, but doesn't matter
	buf #50 writeCarry(carry_out, 1'b0);

	
	endmodule
	

	


/*
.B(B), .negative(negativeAll[0]), .zero(zeroAll[0]), 
							.overflow(overflowAll[0]), .carry_out(carry_outAll[0], .result(B_Result));
*/