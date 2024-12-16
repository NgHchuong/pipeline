module write_cycle(
 // input declaring
	input logic        insn_vldW,
	input logic [1:0]  ResultSrcW,
	input logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
 // output declaring
	output logic        insn_vld,
	output logic [31:0] ResultW
);

// Declaration of Module
wb_mux wb_mux (   
   .wb_sel(ResultSrcW),
	.o_alu_data(ALU_ResultW),
	.pc(PCPlus4W),
   .o_ld_data(ReadDataW),
   .wb_data(ResultW)
  );
	assign insn_vld = (insn_vldW) ? 1'b1 : 1'b0;
endmodule : write_cycle
