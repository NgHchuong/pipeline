`include "timescale.svh"

module lsu(
    input logic i_clk,
    input logic i_rst,
    input logic i_lsu_wren,
    input logic [31:0] i_lsu_addr,
    input logic [31:0] i_st_data,
    input logic [31:0] i_io_sw,
    input logic [3:0] i_io_btn,

    output logic [31:0] o_ld_data,
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

    // dmem
    localparam MEM_SIZE = 2024; 
    logic [31:0] data_memory [0:MEM_SIZE-1]; //8kiB

    // Reset logic
    always_ff @(posedge i_clk) begin
        if (!i_rst) begin
            o_io_ledr <= 32'd0;
            o_io_ledg <= 32'd0;
            o_io_hex0 <= 7'd0;
            o_io_hex1 <= 7'd0;
            o_io_hex2 <= 7'd0;
            o_io_hex3 <= 7'd0;
            o_io_hex4 <= 7'd0;
            o_io_hex5 <= 7'd0;
            o_io_hex6 <= 7'd0;
            o_io_hex7 <= 7'd0;
            o_io_lcd <= 32'd0;
            o_ld_data <= 32'd0;
        end
        else begin
            if (i_lsu_wren) begin
                // Ghi vào data_memory
                if (i_lsu_addr >= 32'h2000 && i_lsu_addr < (32'h2000 + MEM_SIZE * 4)) begin
                    data_memory[(i_lsu_addr - 32'h2000) >> 2] <= i_st_data;
                end
                // Ghi vào LED đỏ
                else if (i_lsu_addr >= 32'h7000 && i_lsu_addr <= 32'h700F) begin
                    o_io_ledr <= i_st_data;
                end
                // Ghi vào LED xanh
                else if (i_lsu_addr >= 32'h7010 && i_lsu_addr <= 32'h701F) begin
                    o_io_ledg <= i_st_data;
                end
                // Ghi vào HEX
                else if (i_lsu_addr >= 32'h7020 && i_lsu_addr <= 32'h7027) begin
                    o_io_hex0 <= i_st_data[6:0];
                    o_io_hex1 <= i_st_data[14:8];
                    o_io_hex2 <= i_st_data[22:16];
                    o_io_hex3 <= i_st_data[30:24];
                end
                // Ghi vào LCD
                else if (i_lsu_addr >= 32'h7030 && i_lsu_addr <= 32'h703F) begin
                    o_io_lcd <= i_st_data;
                end
            end
            else begin
                // Đọc từ data_memory
                if (i_lsu_addr >= 32'h2000 && i_lsu_addr < (32'h2000 + MEM_SIZE * 4)) begin
                    o_ld_data <= data_memory[(i_lsu_addr - 32'h2000) >> 2];
                end
                // Đọc từ LED đỏ
                else if (i_lsu_addr >= 32'h7000 && i_lsu_addr <= 32'h700F) begin
                    o_ld_data <= o_io_ledr;
                end
                // Đọc từ LED xanh
                else if (i_lsu_addr >= 32'h7010 && i_lsu_addr <= 32'h701F) begin
                    o_ld_data <= o_io_ledg;
                end
                // Đọc từ switch
                else if (i_lsu_addr >= 32'h7800 && i_lsu_addr <= 32'h780F) begin
                    o_ld_data <= i_io_sw;
                end
                else begin
                    o_ld_data <= 32'd0;
                end
            end
        end
    end

endmodule
