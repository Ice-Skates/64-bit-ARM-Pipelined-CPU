module D_FF (q, d, reset, clk);

//run it 64 times for each register

output reg q;

input d, reset, clk;

always_ff @(posedge clk)

	if (reset)
	
		q <= 0; // On reset, set to 0
		
	else
	
		q <= d; // Otherwise out = d
		
		
endmodule