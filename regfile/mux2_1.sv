`timescale 1ps/1ps


module mux2_1(out, i0, i1, sel);



	output logic out;
	
	input logic i0, i1, sel;
	

	
	logic temp1;
	logic temp2;
	logic notsel;
	
	not #50 notselect (notsel, sel);
	and #50 firstAnd  (temp1, i1, sel);
	and #50 secondAnd  (temp2, i0, notsel);
	or #50 outOr  (out, temp1, temp2);
	
	endmodule
	
	
	module mux2_1_testbench();
		logic i0, i1, sel;
		logic out;
		mux2_1 dut (.out, .i0, .i1, .sel);
		initial begin
		
		sel=0; i0=0; i1=0; #10;
		sel=0; i0=0; i1=1; #10;
		sel=0; i0=1; i1=0; #10;
		sel=0; i0=1; i1=1; #10;
		sel=1; i0=0; i1=0; #10;
		sel=1; i0=0; i1=1; #10;
		sel=1; i0=1; i1=0; #10;
		sel=1; i0=1; i1=1; #10;
end
endmodule