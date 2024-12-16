`include "timescale.svh"
module ID_stage (
    input logic i_clk, i_rst, rd_wren_w
    input logic [31:0] instrD, instrW      // Instruction decoded
    input logic [31:0] pc_d,
    input logic [31:0] wb_data_w,  
    output logic [31:0] rs1_data_d,    // Output rs1 
    output logic [31:0] rs2_data_d,    // Output rs2 
    output logic [31:0] imm_out_d,    // Output immediate data
    output logic [3:0] alu_op_d,           // ALU operation
    output logic insn_vld_d, br_un_d, opb_sel_d, mem_wren_d, wb_sel_d, opa_sel_d, rd_wren_d
);

    // Control Unit
    ControlUnit controlunit (
        .alu_op (alu_op_d),
        .instr (instrD),
        .rd_wren(rd_wren_d),
        .insn_vld (insn_vld_d),
        .br_un (br_un_d),
        .opa_sel (opa_sel_d)
        .opb_sel (opb_sel_d),
        .mem_wren (mem_wren_d),
        .wb_sel (wb_sel_d)	
    );

    // Register File
    regfile regfile (
        .i_clk (i_clk),
        .i_rst (i_rst),
        .i_rs1_addr (instrD[19:15]),
        .i_rs2_addr (instrD[24:20]),
        .i_rd_addr (instrW[11:7]),
        .i_rd_data (wb_data_w),
        .rs1_data (rs1_data_d),
        .rs2_data (rs2_data_d),
        .i_rd_wren (rd_wren_w)
    );

    // Immediate Generation
    ImmGen imm_gen (
        .instr (instrD),
        .imm_out (imm_out_d)
    );

endmodule