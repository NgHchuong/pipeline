`include "timescale.svh"
module MEM_stage (
    input logic i_clk,
    input logic [31:0] instrM,
    input logic [31:0] alu_data_m,
    input logic [31:0] rs2_data_m,
    input logic [31:0] pc_m,
    input logic mem_wren_m, rd_wren_m, wb_sel_m,
    input logic [31:0] i_io_sw,
    output logic [31:0] ld_data_m,
    output logic [31:0] o_io_ledr,
    output logic [31:0] o_io_ledg,
    output logic [6:0] o_io_hex0,
    output logic [6:0] o_io_hex1,
    output logic [6:0] o_io_hex2,
    output logic [6:0] o_io_hex3,
    output logic [6:0] o_io_hex4,
    output logic [6:0] o_io_hex5,
    output logic [6:0] o_io_hex6,
    output logic [6:0] o_io_hex7,
    output logic [31:0] o_io_lcd
);
    lsu lsu (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .i_lsu_addr (alu_data_m),
        .i_st_data (rs2_data_m),
        .i_lsu_wren(mem_wren_m),
        .o_ld_data(ld_data_m),
        .i_io_sw(i_io_sw),
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
        .o_io_hex7(o_io_hex7)
    );
endmodule