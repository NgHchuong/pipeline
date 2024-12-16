`include "timescale.svh"
module MEM_WB (
    input logic i_clk, i_rst, 
    input logic [31:0] instrM,
    input logic [31:0] alu_data_m,
    input logic [31:0] ld_data_m,
    input logic [31:0] pc_m,
    input logic rd_wren_m, wb_sel_m,
    output logic rd_wren_w, wb_sel_w,
    output logic [31:0] ld_data_w,
    output logic [31:0] instrW,
    output logic [31:0] pc_w,
    output logic [31:0] alu_data_w
);
    always_ff @( posedge i_clk ) begin
        if (!i_rst) begin
            instrM      <= 0;
            alu_data_m  <= 0;
            ld_data_m   <= 0;
            pc_m        <= 0;
            rd_wren_m   <= 0;
            wb_sel_m    <= 0;
        end
        else begin
            instrM      <= instrW;
            alu_data_m  <= alu_data_w;
            ld_data_m   <= ld_data_w;
            pc_m        <= pc_w;
            rd_wren_m   <= rd_wren_w;
            wb_sel_m    <= wb_sel_w;
        end
    end
endmodule