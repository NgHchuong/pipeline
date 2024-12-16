
module imem(
  input  logic [12:0] i_raddr,
  output logic [31:0] o_rdata
);

  logic [3:0][7:0] imem [2**11-1:0];

  initial begin
		imem[0] = 32'h20000393;
		imem[4] = 32'h7003A083;
		imem[8] = 32'h00400113;
		imem[12] = 32'h002081B3;
		imem[16] = 32'h6033A023;
		//$readmemh("./../02_test/dump/mem.dump", imem);
  end

  assign o_rdata = imem[i_raddr[12:2]];

endmodule : imem
