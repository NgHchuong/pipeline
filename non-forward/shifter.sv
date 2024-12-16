module shifter #(
  parameter Width = 32
) (
  input  logic [4:0]			level,
  input  logic [1:0]       shift_mode, // 00: SRL; 01: SLL; 10: SRA
  input  logic [Width-1:0] dataIn,
  output logic [Width-1:0] dataOut
);

  logic [Width-1:0] shiftRegisters, register_0, register_1;
  always @(*) begin
		shiftRegisters = dataIn;
		case (level)
		1: register_0 = 32'h0000_0001;
		2: register_0 = 32'h0000_0003;
		3: register_0 = 32'h0000_0007;
		4: register_0 = 32'h0000_000F;
		5: register_0 = 32'h0000_001F;
		6: register_0 = 32'h0000_003F;
		7: register_0 = 32'h0000_007F;
		8: register_0 = 32'h0000_00FF;
		9: register_0 = 32'h0000_01FF;
		10: register_0 = 32'h0000_03FF;
		11: register_0 = 32'h0000_07FF;
		12: register_0 = 32'h0000_0FFF;
		13: register_0 = 32'h0000_1FFF;
		14: register_0 = 32'h0000_3FFF;
		15: register_0 = 32'h0000_7FFF;
		16: register_0 = 32'h0000_FFFF;
		17: register_0 = 32'h0001_FFFF;
		18: register_0 = 32'h0003_FFFF;
		19: register_0 = 32'h0007_FFFF;
		20: register_0 = 32'h000F_FFFF;
		21: register_0 = 32'h001F_FFFF;
		22: register_0 = 32'h003F_FFFF;
		23: register_0 = 32'h007F_FFFF;
		24: register_0 = 32'h00FF_FFFF;
		25: register_0 = 32'h01FF_FFFF;
		26: register_0 = 32'h03FF_FFFF;
		27: register_0 = 32'h07FF_FFFF;
		28: register_0 = 32'h0FFF_FFFF;
		29: register_0 = 32'h1FFF_FFFF;
		30: register_0 = 32'h3FFF_FFFF;
		31: register_0 = 32'h7FFF_FFFF;
		32: register_0 = 32'hFFFF_FFFF;
		default: register_0 = 32'h0000_0000;
	endcase

    if ( (shift_mode == 2'b00) & (level != 31) ) begin
      shiftRegisters = {register_0, shiftRegisters[Width-1:1]};
    end
    else if ((shift_mode == 2'b01) & (level != 31)) begin
      shiftRegisters = {shiftRegisters[Width-level+1:0], register_0 [level-1:0]};
    end
	 else if ((shift_mode == 2'b10) & (level != 31) & (dataIn [Width-1] == 1)) begin
		shiftRegisters = {register_1 [level-1:0], shiftRegisters[Width-level:1]};
	 end
	 else if ((shift_mode == 2'b10) & (level != 31) & (dataIn [Width-1] == 0)) begin
		shiftRegisters = {register_0 [level-1:0], shiftRegisters[Width-level:1]};
	 end
	 else begin
		shiftRegisters = 32'h0000_0000;
	 end
	 
  end
  assign register_0 = 32'h0000_0000;
  assign register_1 = 32'hFFFF_FFFF;
  assign dataOut = shiftRegisters;

endmodule : shifter