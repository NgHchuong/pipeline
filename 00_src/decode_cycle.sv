module decode_cycle(

 // input declaring
    input  logic        i_clk, i_rst_n, RegWriteW,
    input  logic  [4:0] RD_ADDR_W,
    input  logic [31:0] InstrD, PCD, PCPlus4D, ResultW,
 //output declaring
    output logic 			RegWriteE, MemWriteE, br_unE, opa_selE, opb_selE,
    output logic  [1:0] ResultSrcE,
    output logic  [3:0] ALUControlE,
    output logic [31:0] RS1_E, RS2_E, Imm_Ext_E,
    output logic  [4:0] RS1_ADDR_E, RS2_ADDR_E, 
    output logic  [4:0] RD_ADDR_E,
    output logic [31:0] PCE, PCPlus4E,
	 output logic        insn_vldE
);
    // Declare interim wires
    logic 		  insn_vldD, RegWriteD, MemWriteD, opa_selD, opb_selD, br_unD;
    logic  [1:0] ResultSrcD;
    logic  [3:0] ALUControlD;
    logic [31:0] RS1_D, RS2_D;
    logic [31:0] Imm_Gen_D;

    // Declare buffers
    logic 		  insn_vld_t, RegWriteD_t, MemWriteD_t, br_unD_t, opa_selD_t, opb_selD_t;
    logic  [1:0] ResultSrcD_t;
    logic  [3:0] ALUControlD_t;
    logic [31:0] RS1_D_t, RS2_D_t; 
    logic [31:0] Imm_Gen_D_t;
    logic  [4:0] RD_ADDR_t;
    logic  [4:0] RS1_ADDR_t, RS2_ADDR_t; 
    logic [31:0] PCD_t, PCPlus4D_t;
	 
    // Initiate the modules
    // Control Unit
    ControlUnit control_unit (                      
                            .instr(InstrD),
                            .rd_wren(RegWriteD),
									 .insn_vld(insn_vldD),		 
                            .br_un(br_unD),
                            .opa_sel(opa_selD),
                            .opb_sel(opb_selD),
									 .alu_op(ALUControlD),
									 .mem_wren(MemWriteD),
                            .wb_sel(ResultSrcD)	
                            );

    // Register File
    regfile regfile(
                        .i_clk(i_clk),
                        .i_rst(i_rst_n),
				            .i_rs1_addr(InstrD[19:15]),
                        .i_rs2_addr(InstrD[24:20]),
								.rd_addr(RD_ADDR_W),
	                     .i_rd_data(ResultW),                    
                        .i_rd_wren(RegWriteW),
                        .rs1_data(RS1_D),
                        .rs2_data(RS2_D)
                        );

    // Immediate Generator
    ImmGen imm_gen (
                        .instr(InstrD),
                        .instr_gen(Imm_Gen_D)
                        );

    // Declaring Register Logic
    always_ff@(posedge i_clk or negedge i_rst_n) begin
        if(~i_rst_n) begin
				insn_vld_t   <= 1'b0;
            RegWriteD_t   <= 1'b0;
            MemWriteD_t   <= 1'b0;
            ResultSrcD_t  <= 2'b0;
            br_unD_t      <= 1'b0;
            opa_selD_t    <= 1'b0;
            opb_selD_t 	  <= 1'b0;
            ALUControlD_t <= 4'b0;
            RS1_D_t 		  <= 32'h0; 
            RS2_D_t 		  <= 32'h0; 
            Imm_Gen_D_t   <= 32'h0;
				PCD_t 		  <= 32'h0; 
            PCPlus4D_t 	  <= 32'h0;
            RD_ADDR_t 	  <= 5'h0;
            RS1_ADDR_t 	  <= 5'h0; 
            RS2_ADDR_t 	  <= 5'h0; 
        end
        else begin
            RegWriteD_t   <= RegWriteD;
            MemWriteD_t   <= MemWriteD;
            ResultSrcD_t  <= ResultSrcD;
				br_unD_t  	  <= br_unD;
				opa_selD_t    <= opa_selD;
				opb_selD_t 	  <= opb_selD;
            ALUControlD_t <= ALUControlD;
            RS1_D_t 		  <= RS1_D; 
            RS2_D_t 		  <= RS2_D; 
            Imm_Gen_D_t   <= Imm_Gen_D;
            RD_ADDR_t     <= InstrD[11:7];
            PCD_t 		  <= PCD; 
            PCPlus4D_t    <= PCPlus4D;
            RS1_ADDR_t    <= InstrD[19:15]; 
            RS2_ADDR_t    <= InstrD[24:20]; 
				insn_vld_t    <= insn_vldD;
        end
    end

    // Output asssign 
    assign RegWriteE   = RegWriteD_t;
    assign MemWriteE   = MemWriteD_t;
    assign ResultSrcE  = ResultSrcD_t;
    assign br_unE      = br_unD_t;
    assign opa_selE    = opa_selD_t;
    assign opb_selE    = opb_selD_t;
    assign ALUControlE = ALUControlD_t;
    assign RS1_ADDR_E  = RS1_ADDR_t;
    assign RS2_ADDR_E  = RS2_ADDR_t;
    assign Imm_Gen_E   = Imm_Gen_D_t;
    assign RD_ADDR_E   = RD_ADDR_t;
    assign PCE 		  = PCD_t;
    assign PCPlus4E    = PCPlus4D_t;
    assign RS1_E       = RS1_D_t;
    assign RS2_E       = RS2_D_t;
	 assign insn_vldE   = insn_vld_t;

endmodule : decode_cycle

