`timescale 1ps/1ps


module outputSub (A, B, negative, zero, overflow, carry_out, result);

	input logic [63:0] A, B;
	output logic negative, zero, overflow, carry_out;
	output logic [63:0] result;
	
	// Okay need a full adder.... Let's see
	// 
	
	logic [63:0] invertB;
	
	logic [64:0] carryIn;
	
	genvar n;
	
		generate
		
			for(n = 0; n < 64; n++) begin: invert
			
				not #50 notb(invertB[n], B[n]);
				
			end
			
		endgenerate
		
	
	fa1Bit fa_1(.sum(result[0]), .carryOut(carryIn[1]), .A(A[0]), .B(invertB[0]), .carryIn(1'b1));


	
	genvar i;
	
		generate
		
			for(i = 1; i < 64; i++) begin: add
				
				fa1Bit fa_2(.sum(result[i]), .carryOut(carryIn[i + 1]), .A(A[i]), .B(invertB[i]), .carryIn(carryIn[i]));
				
			end
			
		endgenerate
		
	
	buf #50 negativeWrite(negative, result[63]); //correct, but commented for tests

	xor #50 overflowWrite(overflow, carryIn[63], carryIn[64]);
	
	buf #50 carryWrite(carry_out, carryIn[64]);
	
	checkZero checkZeroAdd(result, zero);
	
	endmodule
	

	

				
	
