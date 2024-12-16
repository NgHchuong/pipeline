`include "timescale.svh"
module EX_stage (
    input logic        br_un_e, opb_sel_e, mem_wren_e, wb_sel_e, opa_sel_e, rd_wren_e
    input logic [31:0] pc_e, instrE          
    input logic [31:0] rs1_data_e,    
    input logic [31:0] rs2_data_e,    
    input logic [31:0] imm_out_e,    
    input logic [3:0] alu_op_e,           
    output logic br_taken
    output logic [31:0] alu_data_e
);
    logic [31:0] i_operand_a;
    logic [31:0] i_operand_b;
    logic br_equal, br_less


    a_mux a_mux (
        .opa_sel (opa_sel_e),
        .pc (pc_e),
        .rs1_data (rs1_data_e),
        .i_operand_a (i_operand_a)
    );
    b_mux b_mux (
        .opb_sel (opb_sel_e),
        .instr (instrE),
        .rs2_data (rs2_data_e),
        .i_operand_b (i_operand_b)
    );
    alu alu_unit (
        .i_operand_a (i_operand_a),
        .i_operand_b (i_operand_b),  
        .i_alu_op (alu_op_e),
        .o_alu_data (alu_data_e)
    );
    BRC BrComp (
        .i_rs1_data (rs1_data_e),
        .i_rs2_data (rs2_data_e),
        .i_br_un (br_un_e),
        .br_equal (br_equal),
        .br_less (br_less)
    );
    branch_sel br_select (
        .instr (instrE),
        .br_less (br_less),
        .br_equal (br_equal),
        .br_taken (br_taken)
    );

endmodule
