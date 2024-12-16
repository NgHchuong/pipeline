`include "timescale.svh"
module ID_EX (
    input logic i_clk, i_rst, StallD, FLushD
    input logic [31:0] pc_d, instrD
    input logic        insn_vld_d, br_un_d, opb_sel_d, mem_wren_d, rd_wren_d, wb_sel_d, opa_sel_d,       
    input logic [31:0] rs1_data_d,    
    input logic [31:0] rs2_data_d,    
    input logic [31:0] imm_out_d,   
    input logic [3:0] alu_op_d,          
    output logic        br_un_e, opb_sel_e, mem_wren_e, wb_sel_e, opa_sel_e, rd_wren_e
    output logic [31:0] pc_e, instrE        
    output logic [31:0] rs1_data_e,    // Output rs1 
    output logic [31:0] rs2_data_e,    // Output rs2 
    output logic [31:0] imm_out_e,    // Output immediate data
    output logic [3:0] alu_op_e           // ALU operation
);
    always_ff @( posedge i_clk ) begin
        if (!i_rst) begin
            pc_d         <= 0;
            instrD       <= 0;
            br_un_d      <= 0;
            opa_sel_d    <= 0;
            opb_sel_d    <= 0;
            mem_wren_d   <= 0;
            rd_wren_d    <= 0;
            wb_sel_d     <= 0;
            rs1_data_d   <= 0;
            rs2_data_d   <= 0;
            imm_out_d    <= 0;
            alu_op_d     <= 0;
        end
        else if (StallD) begin
            pc_d         <= pc_d;
            instrD       <= instrE;
            br_un_d      <= br_un_d;
            opa_sel_d    <= opa_sel_d;
            opb_sel_d    <= opb_sel_d;
            mem_wren_d   <= mem_wren_d;
            rd_wren_d    <= rd_wren_d;
            wb_sel_d     <= wb_sel_d;
            rs1_data_d   <= rs1_data_d;
            rs2_data_d   <= rs2_data_d;
            imm_out_d    <= imm_out_d;
            alu_op_d     <= alu_op_d;
        end
        else if (FLushD) begin
            pc_d         <= 0;
            instrD       <= 0;
            br_un_d      <= 0;
            opa_sel_d    <= 0;
            opb_sel_d    <= 0;
            mem_wren_d   <= 0;
            rd_wren_d    <= 0;
            wb_sel_d     <= 0;
            rs1_data_d   <= 0;
            rs2_data_d   <= 0;
            imm_out_d    <= 0;
            alu_op_d     <= 0;
        end
        else begin
            pc_d         <= pc_e;
            pc_sel_d     <= pc_sel_e;
            br_un_d      <= br_un_e;
            opa_sel_d    <= opa_sel_e;
            opb_sel_d    <= opb_sel_e;
            mem_wren_d   <= mem_wren_e;
            rd_wren_d    <= rd_wren_e;
            wb_sel_d     <= wb_sel_e;
            rs1_data_d   <= rs1_data_e;
            rs2_data_d   <= rs2_data_e;
            imm_out_d    <= imm_out_e;
            alu_op_d     <= alu_op_e;
        end
    end
endmodule