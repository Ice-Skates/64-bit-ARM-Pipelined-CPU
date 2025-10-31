`timescale 1ps/1ps


module checkZero (result, out);

	input logic [63:0] result;
	output logic out;
	
	logic [31:0] firstStage;
	logic [15:0] secondStage;
	logic [7:0] thirdStage;
	logic [3:0] fourthStage;
	logic [2:0] fifthStage;

	
	
	genvar n;
	
		generate
		
			for(n = 0; n < 64; n = n + 2) begin: first
			
				or #50 compareFirst(firstStage[n / 2], result[n], result[n + 1]);
				
			end
			
		endgenerate
		
		
	genvar m;
	
		generate 
		
			for(m = 0; m < 32; m = m + 2) begin: second
			
				or #50 compareSecond(secondStage[m / 2], firstStage[m], firstStage[m + 1]);
				
			end
			
		endgenerate
		
		
	genvar z;
	
		generate 
		
			for(z = 0; z < 16; z = z + 2) begin: third
		
			
				or #50 compareThird(thirdStage[z / 2], secondStage[z], secondStage[z + 1]);
				
			end
			
		endgenerate
		
		
	genvar y;
	
		generate
		
			for(y = 0; y < 8; y = y + 2)  begin: fourth
			
				or #50 compareFourth(fourthStage[y / 2], thirdStage[y], thirdStage[y + 1]);
				
			end
			
			
		endgenerate
		
//	
//	or #50 compareLast_1(fifthStage[0], fourthStage[0], fourthStage[1]);
//	or #50 compareLast_2(fifthStage[1], fourthStage[2], fourthStage[3]);
//	or #50 compareLast_3(fifthStage[2], fourthStage[4], fourthStage[5]);
//	or #50 compareLast_4(fifthStage[3], fourthStage[6], fourthStage[7]);
	
	logic [1:0] lastTwo;
	
	or #50 compareLast_5(lastTwo[0], fourthStage[0], fourthStage[1]);
	or #50 compareLast_6(lastTwo[1], fourthStage[2], fourthStage[3]);

	logic notOut;

	or #50 compareLast_7(notOut, lastTwo[0], lastTwo[1]);
	
	not #50 (out, notOut);

	endmodule