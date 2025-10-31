package structures;

	typedef struct packed { 

		logic	ALU_src;
		logic [1:0] ALU_op;
		logic setFlags;

	}  struct_EX;


	typedef struct packed {

		logic branch;
		logic	mem_write;
		logic	pc_src;
		logic mem_read;
		logic unconbr;

	}	struct_MEM;


	typedef struct packed {
		
		logic reg_write;
		logic mem_to_reg;
		
	}	struct_WB;
	
	 typedef struct packed {
	 
	  logic D_type;     // LDUR / STUR   (9-bit imm)
	  logic I_type;     // ADDI / SUBI … (12-bit imm)
	  logic B_type;     // B / BL        (26-bit imm <<2)
	  logic CB_type;    // CBZ / CBNZ    (19-bit imm <<2)
	  logic cbz_op;
	  logic blt_op;
	  
	} format_type;
	
	
endpackage : structures
