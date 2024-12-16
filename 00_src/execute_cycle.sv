module execute_cycle(
	// input declaring
	 input              i_clk, i_rst_n, RegWriteE, MemWriteE, br_unE, opa_selE, opb_selE, insn_vldE,
  	 input logic  [1:0] ResultSrcE,
    input logic  [3:0] ALUControlE,
    input logic [31:0] RS1_E, RS2_E, Imm_Gen_E,
    input logic  [4:0] RD_ADDR_E,
    input logic [31:0] PCE, PCPlus4E,
    input logic [31:0] ResultW,
	 input logic  [1:0] ForwardA_E, ForwardB_E,
	// output declaring
    output logic        insn_vldM, PCSrcE, RegWriteM, MemWriteM, 
    output logic  [1:0] ResultSrcM,
    output logic  [4:0] RD_ADDR_M,
    output logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    output logic [31:0] PCTargetE
);
    // Declaring interim wires
    logic [31:0] Src_A, Src_B, Src_A_w, Src_B_w;
    logic [31:0] ResultE;
    logic	     br_equalE, br_lessE;

    // Declaring buffers
    logic 		  RegWriteE_t, MemWriteE_t;
    logic  [1:0] ResultSrcE_t;
    logic  [4:0] RD_ADDR_E_t;
    logic [31:0] PCPlus4E_t, RS2_E_t, ResultE_t;

    // Declaration of Modules
	a_mux_forward a_mux_forward(
	.in_a(RS1_E),
	.in_b(ResultW),
	.in_c(ALU_ResultM),
	.sel(ForwardA_E),
	.out(Src_A_w)	
	);
	
    mux_a mux_a (
	.opa_sel(opa_selE),
   .rs1_data(Src_A_w),
   .pc(PCE),
   .i_operand_a(Src_A)
    );
                        
	b_mux_forward b_mux_forward(
	.in_a(RS2_E),
	.in_b(ResultW),
	.in_c(ALU_ResultM),
	.sel(ForwardB_E),
	.out(Src_B_w)	
	);
	
    b_mux b_mux (
	 .opb_sel(opb_selE),
    .rs2_data(Src_B_w),
    .instr_gen(Imm_Gen_E),
    .i_operand_b(Src_B)
  	);

    // ALU Unit
    alu alu (
            .i_operand_a(Src_A),
            .i_operand_b(Src_B),
			   .i_alu_op(ALUControlE),
            .o_alu_data(ResultE)
	);

    // Branch Comparator 
	BRC branch_comparator(
		.i_rs1_data(RS1_E),
		.i_rs2_data(RS2_E),
		.i_br_un(br_unE),
		.br_less(br_lessE),
		.br_equal(br_equalE)		
	);
	// control selectial signal for pc 
	ControlUnit control_pc(
		.br_equal(br_equalE),
		.br_less(br_lessE),
		.pc_sel(PCSrcE),		
	);
	
    // Register Logic
   always_ff@(posedge i_clk or negedge i_rst_n) begin
        if(~i_rst_n) begin
            RegWriteE_t  <= 1'b0; 
            MemWriteE_t  <= 1'b0; 
            ResultSrcE_t <= 2'b0;
            RD_ADDR_E_t  <= 5'h0;
            PCPlus4E_t   <= 32'h0; 
            RS2_E_t 		 <= 32'h0; 
            ResultE_t 	 <= 32'h0;
        end
        else begin
            RegWriteE_t  <= RegWriteE; 
            MemWriteE_t  <= MemWriteE; 
            ResultSrcE_t <= ResultSrcE;
            RD_ADDR_E_t  <= RD_ADDR_E;
            PCPlus4E_t   <= PCPlus4E; 
            RS2_E_t      <= Src_B; 
            ResultE_t    <= ResultE;
        end
    end

    // Output Assignments
    assign RegWriteM   = RegWriteE_t;
    assign MemWriteM   = MemWriteE_t;
    assign ResultSrcM  = ResultSrcE_t;
    assign RD_ADDR_M   = RD_ADDR_E_t;
    assign PCPlus4M    = PCPlus4E_t;
    assign WriteDataM  = RS2_E_t;
    assign ALU_ResultM = ResultE_t;
	 assign PCTargetE   = (PCSrcE) ? ResultE : 32'b0;
	 assign insn_vldM   = insn_vldE;

    endmodule : execute_cycle
