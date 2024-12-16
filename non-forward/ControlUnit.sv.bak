module ControlUnit (
 //input
  input logic [31:0] instr,      // Instruction to decode
 //output
  output logic rd_wren, 		   // control signal for Regfile to read rd_data
  output logic insn_vld,			// 
  output logic br_un,				// control signal for BRC
  output logic opb_sel, opa_sel				
  output logic [3:0] alu_op,		// control signal for ALU
  output logic mem_wren,			// control signal for LSU
  output logic wb_sel				// control signal for WB stage
);

  logic [2:0] funct3;
  logic [6:0] opcode;
    assign opcode = instr[6:0];
    assign funct3 = instr[14:12];
    // Define opcode for reading 
  localparam OP_RTYPE     = 7'b0110011;
  localparam OP_ITYPE     = 7'b0010011;
  localparam OP_LD        = 7'b0000011;
  localparam OP_ST        = 7'b0100011;
  localparam OP_BR        = 7'b1100011;

  // Control unit logic
  always @(*) begin
    // Set defaults
   rd_wren  = 0;
	 insn_vld = 0;
	 br_un    = 0;
   opb_sel  = 0;
   opa_sel  = 0;
   alu_op   = 0;
	 mem_wren = 0;
   wb_sel   = 0;
	 
    case (opcode)
      OP_RTYPE: begin
		  insn_vld  = 1;
        rd_wren = 1;
        opb_sel = 0; // rs2
        wb_sel  = 0; // alu_data
         case (funct3)
                3'b000: alu_op = (instr[30])?4'b0001:4'b0000; //SUB, ADD
                3'b010: alu_op = 4'b0010; //SLT 
                3'b011: begin //SLTU
                        alu_op = 4'b0011;
                        br_u = 1'b1;
                        end
                3'b100: alu_op = 4'b0100; //XOR  
                3'b110: alu_op = 4'b0101; //OR
                3'b111: alu_op = 4'b0110; //AND
                3'b001: alu_op = 4'b0111; //SLL
                3'b101: alu_op = (instr[30])?4'b1001:4'b1000; //SRA,SRL 
            endcase
      end
      OP_ITYPE: begin
		  insn_vld  = 1;
        rd_wren = 1;
        opa_sel = 0;
        opb_sel = 1; // imm
        wb_sel  = 0; // alu_data
          case(funct3)
                3'b000 : ALUcontrol = 4'b0000; // ADD
                3'b010 : ALUcontrol = 4'b0010; // SLT
                3'b011 : begin
                  ALUcontrol = 4'b0011;
                  br_u = 1'b1;
                  end // SLTU
                3'b100 : ALUcontrol = 4'b0100; // XOR
                3'b110 : ALUcontrol = 4'b0101; // OR
                3'b111 : ALUcontrol = 4'b0110; // AND
                3'b001 : ALUcontrol = 4'b0111; // SLL
                3'b101 : ALUcontrol = (instr[30])?4'b1001:4'b1000; // SRA_SRL
            endcase
      end
      OP_LD: begin
		    insn_vld  = 1;
        rd_wren   = 1;
        mem_wren  = 0;
        opa_sel   = 0; //reg
        opb_sel   = 1; // imm
        wb_sel    = 1; // ld_data
      end
      OP_ST: begin
        mem_wren  = 1;
		    insn_vld  = 1;
        opa_sel   = 0; //reg
        opb_sel   = 1; // imm
        // wb_sel is not relevant for STORE instructions
      end
      OP_BR: begin
			insn_vld = 1;     
      	case (funct3)
			3'b000: begin
				br_un   = 0;
        opa_sel = 1;
				opb_sel = 1;
			end
			3'b100: begin
			    br_un   = 0;
          opa_sel = 1;
			    opb_sel = 1;
			    end
			3'b110: begin
			    br_un   = 1;
          opa_sel = 1;
			    opb_sel = 1;
			    end
		default;
		endcase
      end
      default;
    endcase
  end


endmodule : ControlUnit
