`include "timescale.svh"

/* verilator lint_off UNUSEDSIGNAL */
module insn_mem(
  input  logic [12:0] i_raddr,
  output logic [31:0] o_rdata
);

  logic [3:0][7:0] imem [2**11-1:0];

  initial begin
    $readmemh("./../02_test/dump/mem.dump", imem);
  end

  assign o_rdata = imem[i_raddr[12:2]];

endmodule : insn_mem
