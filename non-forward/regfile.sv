module regfile (
 //input
  input logic i_clk,        	  // Global clock.
  input logic i_rst,       	  // Global active reset.
  input logic [4:0] i_rs1_addr, // Address of the first source register.
  input logic [4:0] i_rs2_addr, // Address of the second source register.
  input logic [4:0] i_rd_addr,  // Address of the destination register.
  input logic [31:0] i_rd_data, // Data to write to the destination register.
  input logic i_rd_wren,        // Write enable for the destination register.
 //output
  output logic [31:0] rs1_data, // Read data for rs1
  output logic [31:0] rs2_data  // Read data for rs2
);

  logic [31:0] registers [31:0]; // 32 32-bit registers

  // Asynchronous reset
  always @(posedge i_clk) begin
    if (!i_rst)
      registers[0] <= 32'h0; // Register 0 always holds 0 during reset
    else if (i_rd_wren)
      registers[i_rd_addr] <= i_rd_data;
  end

  // Combinational logic to read from registers
  assign rs1_data = registers[i_rs1_addr];
  assign rs2_data = registers[i_rs2_addr];

  // Write data to regfile.data file
  initial begin
    $dumpfile("regfile.data");
    $dumpvars(0, regfile);
  end

endmodule : regfile
