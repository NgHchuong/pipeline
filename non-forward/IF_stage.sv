`include "timescale.svh"
module IF_stage (
    input logic i_clk,                     // Tín hiệu đồng hồ
    input logic i_rst,                   // Tín hiệu reset
    input logic br_taken, stall_pc                 // Chọn PC tiếp theo (để quyết định nhánh hay không)
    input logic [31:0] pc_target,       //pc offset
    output logic [31:0] instrF,         // Lệnh đọc được từ bộ nhớ
    output logic [31:0] pc_f            // Địa chỉ PC hiện tại
);

    // Tín hiệu PC và địa chỉ đọc lệnh từ bộ nhớ
    logic [31:0] pc_next;

    // PC
    pc pc (
        .i_clk(i_clk),
        .i_rst(i_rst),
        .pc_next(pc_next),
        .pc(pc_f),
        .stall_pc (stall_pc)
    );

    
    pc_mux pc_mux (
        .pc_sel(br_taken),
        .pc(pc_f),
        .o_alu_data(pc_target),
        .pc_next(pc_next)
    );

    // Instruction Memory 
    insn_mem insn_mem (
        .i_raddr(pc_f[12:2]),    
        .o_rdata(instrF)        // Lệnh đọc được từ bộ nhớ
    );

endmodule : IF_stage