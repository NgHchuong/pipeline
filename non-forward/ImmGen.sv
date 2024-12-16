module Immgen (
    input logic [31:0] instr,
    output logic [31:0] imm_out
);
    logic [2:0] funct3;
    logic [6:0] opcode;
    assign opcode = instr [6:0];
    assign funct3 = instr[14:12];

always_comb begin
    case (opcode)
        7'b0010011: //I-type
        imm_out = {{21{instr[31]}}, instr[30:25], instr[24:21], instr[20]};
        7'b0000011: //Load
        imm_out = {{21{instr[31]}}, instr[30:25], instr[24:21], instr[20]};
        7'b0100011: //S-type
        imm_out = {{21{instr[31]}}, instr[30:25], instr[11:7]};
        7'b1100011: //B-type
        imm_out = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        7'b1101111: //J-type
        imm_out = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21],1'b0};
        7'b1100111: //JALR
        imm_out = {{21{instr[31]}}, instr[30:25], instr[24:20]};
        7'b0010111: //AUIPC
        imm_out = {instr[31:12], {12{1'b0}}};
        7'b0110111: //U-type
        imm_out = {instr[31:12], {12{1'b0}}};
        default   : imm_out = 32'd0;
    endcase
end
endmodule