`timescale 1ps/1ps


module enDecoder3_8(enable, in, out);
    input logic enable;
    input logic [2:0] in;
    output logic [7:0] out;
    
    and #50 de3to8_1 (out[0], ~in[2], ~in[1], ~in[0], enable);
    and #50 de3to8_2 (out[1], ~in[2], ~in[1], in[0], enable);
    and #50 de3to8_3 (out[2], ~in[2], in[1], ~in[0], enable);
    and #50 de3to8_4 (out[3], ~in[2], in[1], in[0], enable);
    and #50 de3to8_5 (out[4], in[2], ~in[1], ~in[0], enable);
    and #50 de3to8_6 (out[5], in[2], ~in[1], in[0], enable);
    and #50 de3to8_7 (out[6], in[2], in[1], ~in[0], enable);
    and #50 de3to8_8 (out[7], in[2], in[1], in[0], enable);
	 
endmodule
