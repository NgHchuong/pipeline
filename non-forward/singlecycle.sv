module singlecycle (
	//input declar
	input  logic i_clk, 			      //Global clock, active on the rising edge.
	input  logic i_rst_n, 			   //Global low active reset.
	//output declar
	output logic [31:0] o_pc_debug,  //Debug program counter.
	output logic 		  o_insn_vld,  //Instruction valid.
	output logic [31:0] o_io_ledr, 	//Output for driving red LEDs.
	output logic [31:0] o_io_ledg, 	//Output for driving green LEDs.
	output logic [6:0]  o_io_hex0,	//Output for driving 7-segment LED displays.
	output logic [6:0]  o_io_hex1,
	output logic [6:0]  o_io_hex2,
	output logic [6:0]  o_io_hex3,
	output logic [6:0]  o_io_hex4,
	output logic [6:0]  o_io_hex5,
	output logic [6:0]  o_io_hex6,
	output logic [6:0]  o_io_hex7,
	output logic [31:0] o_io_lcd,		//Output for driving the LCD register.
	// input from peripherals
	input logic [31:0]i_io_sw,   		//Input for switches.
	output logic [17:0]   SRAM_ADDR,
  inout  wire  [15:0]   SRAM_DQ  ,
  output logic          SRAM_CE_N,
  output logic          SRAM_WE_N,
  output logic          SRAM_OE_N,
  output logic          SRAM_LB_N,
  output logic          SRAM_UB_N
);
	logic [31:0] pc_next, pc, o_alu_data, instr, rs1_data, rs2_data, instr_gen, i_rd_data, i_operand_a, i_operand_b, wb_data, o_ld_data;
	logic [4:0]  i_rs1_addr, i_rs2_addr, i_rd_addr;
	logic [3:0]  alu_op;
	logic [1:0]  wb_sel;
  	logic 		 pc_sel, i_rd_wren, br_less, br_equal, rd_wren, insn_vld, br_un, opa_sel, opb_sel, mem_wren;
pc PC (
	.i_clk(i_clk),
	.i_rst(i_rst),
	.pc_next(pc_next),
	.pc(pc)
);

pc_mux pc_mux (
	.pc_sel (pc_sel),
	.pc (pc),
	.o_alu_data(o_alu_data),
	.pc_next(pc_next)
);

imem imem(
	.i_raddr(pc[12:0]),
	.o_rdata(instr)
);

regfile regfile(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_rs1_addr(instr[19:15]),
	.i_rs2_addr(instr[24:20]),
	.i_rd_addr(instr[11:7]),
	.i_rd_data(wb_data),
	.i_rd_wren(i_rd_wren),
	.rs1_data(rs1_data),
	.rs2_data(rs2_data)
);

ImmGen ImmGen(
	.instr(instr),
	.instr_gen(instr_gen)
);

ControlUnit ControlUnit(
	.br_less (br_less),
	.br_equal (br_equal),
	.instr (instr),
	.pc_sel (pc_sel),
	.rd_wren(rd_wren),
	.insn_vld (insn_vld),
	.br_un(br_un),
	.opa_sel(opa_sel),
	.opb_sel(opb_sel),
	.alu_op (alu_op),
	.mem_wren(mem_wren),
	.wb_sel(wb_sel)	
);

BRC BRC(
	.i_rs1_data(rs1_data),
	.i_rs2_data(rs2_data),
	.i_br_un(br_un),
	.br_less(br_less),
	.br_equal(br_equal)
);

a_mux a_mux(
	.opa_sel(opa_sel),
	.pc(pc),
	.rs1_data(rs1_data),
	.i_operand_a(i_operand_a)
);

b_mux b_mux(
	.opb_sel(opb_sel),
	.instr_gen(instr_gen),
	.rs2_data(rs2_data),
	.i_operand_b(i_operand_b)
);

alu alu(
	.i_operand_a(i_operand_a),
	.i_operand_b(i_operand_b),
	.i_alu_op(alu_op),
	.o_alu_data(o_alu_data)
);

lsu lsu(
	.i_clk(i_clk),
	.i_rst(i_rst),
	.i_lsu_addr (o_alu_data),
	.i_st_data (rs2_data),
	.i_lsu_wren(mem_wren),
	.i_io_sw(i_io_sw),
	.o_ld_data(o_ld_data),
	.o_io_lcd(o_io_lcd), 
	.o_io_ledg(o_io_ledg), 
	.o_io_ledr(o_io_ledr),
	.o_io_hex0(o_io_hex0), 
	.o_io_hex1(o_io_hex1), 
	.o_io_hex2(o_io_hex2),
	.o_io_hex3(o_io_hex3),
	.o_io_hex4(o_io_hex4),
	.o_io_hex5(o_io_hex5),
	.o_io_hex6(o_io_hex6),
	.o_io_hex7(o_io_hex7),
	.SRAM_ADDR(SRAM_ADDR),
	.SRAM_DQ(SRAM_DQ)  ,
   .SRAM_CE_N(SRAM_CE_N),
   .SRAM_WE_N(SRAM_WE_N),
   .SRAM_OE_N(SRAM_OE_N),
   .SRAM_LB_N(SRAM_LB_N),
   .SRAM_UB_N(SRAM_UB_N)
	
);

wb_mux wb_mux(
	.wb_sel(wb_sel),
	.o_alu_data(o_alu_data),
	.pc(pc),
	.o_ld_data(o_ld_data),
	.wb_data(wb_data)
);

pc_debug pc_debug (
	.pc (pc),
	.o_pc_debug (o_pc_debug)
);

endmodule : singlecycle