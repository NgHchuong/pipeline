module ControlUnit (
 //input
  input logic br_less, br_equal, // result signal form BRC
  input logic [31:0] instr,      // Instruction to decode
 //output
  output logic pc_sel, 				// control signal for pc 
  output logic rd_wren, 		   // control signal for Regfile to read rd_data
  output logic insn_vld,			// 
  output logic br_un,				// control signal for BRC
  output logic opa_sel,				//
  output logic opb_sel,				//
  output logic [3:0] alu_op,				// control signal for ALU
  output logic mem_wren,			// control signal for LSU
  output logic [1:0] wb_sel				// control signal for WB stage
);
  logic [2:0] funct3;
  logic [6:0] funct7, opcode;
   
    // Define opcode for reading 
  localparam OP_RTYPE     = 7'b0110011;
  localparam OP_ITYPE     = 7'b0010011;
  localparam OP_LD        = 7'b0000011;
  localparam OP_ST        = 7'b0100011;
  localparam OP_BR        = 7'b1100011;

  // Control unit logic
  always @(*) begin
    // Set defaults
	pc_sel = 0;
   rd_wren = 0;
	insn_vld = 0;
   br_un = 0;
   opa_sel = 0;
   opb_sel = 0;
   alu_op = 0;
   mem_wren = 0;
   wb_sel = 2'b0;
	 
    case (opcode)
      OP_RTYPE: begin
		  insn_vld = 1;
        pc_sel  = 0;
        rd_wren = 1;
        br_un   = 0;
        opa_sel = 0; // rs1
        opb_sel = 0; // rs2
        wb_sel = 2'b00; // alu_data
        case (funct3)
          3'b000: alu_op = funct7[5] ? 4'b0001 : 4'b0000; // SUB or ADD
          3'b010: alu_op = 4'b0010; // SLT
          3'b011: alu_op = 4'b0011; // SLTU
          3'b111: alu_op = 4'b0110; // AND
          3'b110: alu_op = 4'b0011; // OR
          3'b100: alu_op = 4'b0100; // XOR
          3'b001: alu_op = 4'b0111; // SLL
          3'b101: alu_op = funct7[5] ? 4'b1001 : 4'b1000; // SRA or SRL
                endcase
      end
      OP_ITYPE: begin
		  insn_vld = 1;
        pc_sel  = 0;
        rd_wren = 1;
        br_un   = 0;
        opa_sel = 0; // rs1
        opb_sel = 1; // imm
        wb_sel = 2'b00; // alu_data
          case (funct3)
            3'b000: alu_op = funct7[5] ? 4'b0001 : 4'b0000; // SUB or ADD
            3'b010: alu_op = 4'b0010; // SLT
            3'b011: alu_op = 4'b0011; // SLTU
            3'b111: alu_op = 4'b0110; // AND
            3'b110: alu_op = 4'b0011; // OR
            3'b100: alu_op = 4'b0100; // XOR
            3'b001: alu_op = 4'b0111; // SLL
            3'b101: alu_op = funct7[5] ? 4'b1001 : 4'b1000; // SRA or SRL
                endcase
      end
      OP_LD: begin
		  insn_vld = 1;
        rd_wren = 1;
        pc_sel  = 0;
        br_un   = 0;
        mem_wren = 0;
        opa_sel = 0; // rs1
        opb_sel = 1; // imm
        wb_sel = 2'b01; // ld_data
        alu_op = 4'b0000;
      end
      OP_ST: begin
      insn_vld = 1;
        rd_wren  = 0;
        pc_sel   = 0;
        br_un    = 0;
        mem_wren = 1;
        opa_sel = 0; // rs1
        opb_sel = 1; // imm
        wb_sel  = 2'b00; // wb_sel is not relevant for STORE instructions
        alu_op  = 4'b0000;
      end
      OP_BR: begin
			insn_vld = 1;   
			rd_wren  = 0;
			mem_wren = 0;  
			alu_op   = 4'b0000;
			wb_sel   = 2'b00;
      	case (funct3)
			3'b000: begin         //BEQ
				br_un = 0;
				opa_sel = 1;
				opb_sel = 1;
				pc_sel  = br_equal ? 1 : 0;
			end
			3'b100: begin         //BLT
			    br_un = 0;
			    opa_sel = 1;
			    opb_sel = 1;
				 pc_sel = br_less ? 1 : 0;
			    end
			3'b110: begin         //BLTU
			    br_un = 1;
			    opa_sel = 1;
			    opb_sel = 1;
				 pc_sel = br_less ? 1 : 0;
			    end
				endcase
      end
      7'b1101111: begin // JAL
                rd_wren = 1;
                mem_wren =0;
                insn_vld = 1;
                pc_sel = 1;
                br_un  = 0;
                opa_sel = 1;
                opb_sel = 1;
                wb_sel = 2'b10;
                alu_op = 4'b0000;
            end
		default: begin
                    // Default case
                rd_wren = 0;
                insn_vld = 0;
                pc_sel = 0;
                br_un = 0;
                opa_sel = 0;
                opb_sel = 0;
                alu_op = 4'b0000;
                mem_wren = 0;
                wb_sel = 0;
    end
		endcase
  end

  // logic design
  assign funct3 = instr [14:12];
  assign funct7 = instr [31:25];


endmodule : ControlUnit
