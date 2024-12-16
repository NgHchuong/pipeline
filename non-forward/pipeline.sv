module pipeline (
    input logic i_clk, i_rst,	   
);  
    logic [31:0] instrD, instrE, instrF, instrM, instrW;
    logic [31:0] pc_f, pc_d, pc_e, pc_m, pc_w, alu_data_e, alu_data_m, alu_data_w, ld_data_m, ld_data_w;
    logic [3:0] alu_op_d, alu_op_e;
    logic [31:0] imm_out_d, imm_out_e, rs1_data_d, rs2_data_d, wb_data_w, rs1_data_e, rs2_data_e, rs2_data_m
    logic br_taken, stall_pc, StallF, FlushF, StallD, FLushD, StallE, FlushE, insn_vld, rd_wren_d, rd_wren_m, rd_wren_w, rd_wren_e, br_un_d, br_un_e;
    logic opa_sel_d, opa_sel_e, opb_sel_d, opb_sel_e, mem_wren_d, mem_wren_m, mem_wren_e, wb_sel_d, wb_sel_e, wb_sel_m, wb_sel_w
    .IF_stage IF (
        .i_clk (i_clk),                     
        .i_rst (i_rst),                   
        .br_taken (br_taken),                
        .pc_target (alu_data_e),     
        .instrF (instrF),        
        .pc_f (pc_f),
        .stall_pc (stall_pc)
    );
    .IF_ID IF_ID (
        .i_clk (i_clk),
        .i_rst (i_rst),
        .instrF (instrF),
        .instrD (instrD),
        .pc_f (pc_f),
        .pcD (pc_d),
        .StallF (StallF),
        .FLushF (FlushF)
    );
    ID_stage ID (
        .alu_op_d (alu_op_d),
        .instrD (instrD),
        .rd_wren_d (rd_wren_d),
        .insn_vld_d (insn_vld_d),
        .br_un_d (br_un_d),
        .opa_sel_d (opa_sel_d)
        .opb_sel_d (opb_sel_d),
        .mem_wren_d (mem_wren_d),
        .wb_sel_d (wb_sel_d)
        .instrD (instrD),
        .instrW (instrW),
        .pc_d (pc_d),
        .rd_data (wb_data_w),
        .rs1_data_d (rs1_data_d),
        .rs2_data_d (rs2_data_d),
        .imm_out_d (imm_out_d),
        .rd_wren_w (rd_wren_w)
    );
    ID_EX ID_EX (
        .i_clk (i_clk), 
        .i_rst (i_rst), 
        .StallD (StallD), 
        .FLushD (FlushD),
        .pc_d (pc_d), 
        .instrD (instrD),
        .br_un_d (br_un_d), 
        .opb_sel_d (opb_sel_d), 
        .mem_wren_d (mem_wren_d), 
        .rd_wren_d (rd_wren_d),
        .wb_sel_d (wb_sel_d), 
        .opa_sel_d (opa_sel_d),       
        .rs1_data_d (rs1_data_d),    
        .rs2_data_d (rs2_data_d),    
        .imm_out_d (imm_out_d),   
        .alu_op_d (alu_op_d),          
        .br_un_e (br_un_e), 
        .opb_sel_e (opb_sel_e), 
        .mem_wren_e (mem_wren_e), 
        .wb_sel_e (wb_sel_e), 
        .opa_sel_e (opa_sel_e), 
        .rd_wren_e (rd_wren_e),
        .pc_e (pc_e), 
        .instrE (instrE)        
        .rs1_data_e (rs1_data_e),    
        .rs2_data_e (rs2_data_e), 
        .imm_out_e (imm_out_e),   
        .alu_op_e (alu_op_e)           
    );
    EX_stage EX (
        .br_un_e (br_un_e), 
        .opb_sel_e (opb_sel_e), 
        .mem_wren_e (mem_wren_e), 
        .wb_sel_e (wb_sel_e), 
        .opa_sel_e (opa_sel_e), 
        .rd_wren_e (rd_wren_e),
        .pc_e (pc_e), 
        .instrE (instrE),          
        .rs1_data_e (rs1_data_e),    
        .rs2_data_e (rs2_data_e),    
        .imm_out_e (imm_out_e),    
        .alu_op_e (alu_op_e),           
        .br_taken (br_taken),
        .alu_data_e (alu_data_e)
    );
    EX_MEM EX_MEM (
        .i_clk (i_clk), 
        .i_rst (i_rst), 
        .StallE (StallE), 
        .FlushE (FlushE),
        .alu_data_e (alu_data_e),
        .rs2_data_e (rs2_data_e),
        .instrE (instrE),
        .pc_e (pc_e),
        .wb_sel_e (wb_sel_e), 
        .rd_wren_e (rd_wren_e), 
        .mem_wren_e (mem_wren_e),
        .instrM (instrM),
        .alu_data_m (alu_data_m),
        .rs2_data_m (rs2_data_m),
        .pc_m (pc_m),
        .mem_wren_m (mem_wren_m), 
        .rd_wren_m (rd_wren_m), 
        .wb_sel_m (wb_sel_m)
    );
    MEM_stage MEM (
        .i_clk (i_clk),
        .instrM (instrM),
        .alu_data_m (alu_data_m),
        .rs2_data_m (rs2_data_m),
        .pc_m (pc_m),
        .mem_wren_m (mem_wren_m), 
        .rd_wren_m (rd_wren_m), 
        .wb_sel_m (wb_sel_m),
        .ld_data_m (ld_data_m)
    );
    MEM_WB MEM_WB (
        .i_clk (i_clk), 
        .i_rst (i_rst), 
        .instrM (instrM),
        .alu_data_m (alu_data_m),
        .ld_data_m (ld_data_m),
        .pc_m (pc_m),
        .rd_wren_m (rd_wren_m), 
        .wb_sel_m (wb_sel_m),
        .rd_wren_w (rd_wren_w), 
        .wb_sel_w (wb_sel_w),
        .ld_data_w (ld_data_w),
        .instrW (instrW),
        .pc_w (pc_w),
        .alu_data_w (alu_data_w)
    );
    WB_stage WB (
        .rd_wren_w (rd_wren_w), 
        .wb_sel_w (wb_sel_w),
        .ld_data_w (ld_data_w),
        .instrW (instrW),
        .pc_w (pc_w),
        .alu_data_w (alu_data_w),
        .wb_data_w (wb_data_w),
    );
endmodule