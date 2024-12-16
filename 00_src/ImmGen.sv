module ImmGen (
 //input
  input logic [31:0] instr, // instruction have to generate
 //output
  output logic [31:0] instr_gen  // Generated instruction
);

 always @(*) begin
        case (instr[6:0])
            7'b0010011: instr_gen = {{20{instr[31]}},instr[31:20]};                // I-type
            7'b0000011: instr_gen = {{20{instr[31]}},instr[31:20]};                // Load
				    7'b0100011: instr_gen = {{20{instr[31]}},instr[31:25],instr[11:7]};// Store
				    7'b1100011: instr_gen = {{20{instr[31]}},instr[31:25],instr[11:7]};// B-type
            7'b1101111: instr_gen = {{12{instr[31]}},instr[31:12]};                // JAL
				default: instr_gen = {32{1'b0}};
					 endcase
 /*verilator lint_on UNUSED*/
end	

endmodule : ImmGen
