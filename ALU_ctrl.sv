module ALU_ctrl(

	ALU_ctrl,
	ALU_op,
	instruction_ALU_ctrl


	);
	
	input logic [1:0]  	 ALU_op;
	input logic [10:0]	 instruction_ALU_ctrl;
	
	output logic [2:0]	 ALU_ctrl;
	
	
	// cntrl			Operation						Notes:
	// 000:			result = B						value of overflow and carry_out unimportant
	// 010:			result = A + B
	// 011:			result = A - B
	// 100:			result = bitwise A & B		value of overflow and carry_out unimportant
	// 101:			result = bitwise A | B		value of overflow and carry_out unimportant
	// 110:			result = bitwise A XOR B	value of overflow and carry_out unimportant
	
	//B 		2'b00
	//ADD		2'b01
	//SUB		2'b10
	//other	2'b11
	
//	typedef enum logic [10:0] {
//	
//
//		B		= 11'b000101xxxxx; 
//		BL		= 11'b100101xxxxx;
//		BR 	= 11'b11010110000;
//		CBZ	= 11'b10110100xxx;
//		B.LT	= 11'b01010100xxx;
//		LDUR	= 11'b11111000010;
//		STUR	= 11'b11111000000;
//		
//	}
//	
    always_comb begin: set_ctrl
	
        ALU_ctrl = 3'b111;              

        case (ALU_op)
			  
			  
				2'b00 : begin
					 ALU_ctrl = 3'b000;       //B
				end

				2'b01 : begin
					 ALU_ctrl = 3'b010;       //ADD
				end


				2'b10 : begin
					 ALU_ctrl = 3'b011;      // SUB
				end

				
				2'b11 : begin
					 ALU_ctrl = 3'b000;      // SUB
				end

			endcase
		end
endmodule