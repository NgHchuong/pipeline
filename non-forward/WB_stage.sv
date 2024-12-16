module WB_stage (
    input logic rd_wren_w, wb_sel_w,
    input logic [31:0] ld_data_w,
    input logic [31:0] instrW,
    input logic [31:0] pc_w,
    input logic [31:0] alu_data_w,
    output logic [31:0] wb_data_w,
);
    wb_mux wb_mux
        .pc (pc_w),
        .alu_data (alu_data_w),
        .ld_data (ld_data_w),
        .wb_sel (wb_sel_w),
        .wb_data (wb_data_w)    
endmodule