`include "timescale.svh"
module EX_MEM (
    input logic i_clk, i_rst, StallE, FlushE,
    input logic [31:0] alu_data_e,
    input logic [31:0] rs2_data_e,
    input logic [31:0] instrE,
    input logic [31:0] pc_e,
    input logic wb_sel_e, rd_wren_e, mem_wren_e,
    output logic [31:0] instrM,
    output logic [31:0] alu_data_m,
    output logic [31:0] rs2_data_m,
    output logic [31:0] pc_m,
    output logic mem_wren_m, rd_wren_m, wb_sel_m
);
    always_ff @( posedge i_clk ) begin 
        if (!i_rst) begin
            alu_data_e      <= 0;
            rs2_data_e      <= 0;
            instrE          <= 0;
            pc_e            <= 0;
            wb_sel_e        <= 0;
            rd_wren_e       <= 0;
            mem_wren_e      <= 0;
        end
        else if (StallE) begin
            alu_data_e      <= alu_data_e;
            rs2_data_e      <= rs2_data_e;
            instrE          <= instrE;
            pc_e            <= pc_e;
            wb_sel_e        <= wb_sel_e;
            rd_wren_e       <= rd_wren_e;
            mem_wren_e      <= mem_wren_e;
        end
        else if (FlushE) begin
            alu_data_e      <= 0;
            rs2_data_e      <= 0;
            instrE          <= 0;
            pc_e            <= 0;
            wb_sel_e        <= 0;
            rd_wren_e       <= 0;
            mem_wren_e      <= 0;
        end
        else begin
            alu_data_e      <= alu_data_m;
            rs2_data_e      <= rs2_data_m;
            instrE          <= instrM;
            pc_e            <= pc_m;
            wb_sel_e        <= wb_sel_m;
            rd_wren_e       <= rd_wren_m;
            mem_wren_e      <= mem_wren_m;
        end
    end
endmodule