module pipeline(

	// input declaring
		input  logic        i_clk, i_rst_n,
		input  logic [31:0] i_io_sw,
	// output declaring
		output logic        insn_vld,
		output logic [31:0] o_io_lcd, o_io_ledg, o_io_ledr, o_io_hex_low, o_io_hex_high
);
    // Declaring wires
    logic        PCSrcE, RegWriteW, RegWriteE, MemWriteE, RegWriteM, MemWriteM, opa_selE, opb_selE, br_unE;
	 logic        insn_vldE, insn_vldM, insn_vldW;
    logic  [1:0] ResultSrcE, ResultSrcM, ResultSrcW;
	 logic  [1:0] ForwardBE, ForwardAE;
    logic  [3:0] ALUControlE;
    logic  [4:0] RD_ADDR_E, RD_ADDR_M, RD_ADDR_W;
	 logic  [4:0] RS1_ADDR_E, RS2_ADDR_E;
    logic [31:0] PCTargetE, InstrD, PCD, PCPlus4D, ResultW, RS1_E, RS2_E, Imm_Gen_E, PCE, PCPlus4E, PCPlus4M, WriteDataM, ALU_ResultM;
    logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW;
   
    // Modules Initiation
    // Fetch-Stage
    fetch_cycle fetch (
                        .i_clk_i(i_clk), 
                        .i_rst_n(i_rst_n), 
                        .PCSrcE(PCSrcE), 
                        .PCTargetE(PCTargetE), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D)
                    );

    // Decode-Stage
    decode_cycle decode(
                        .i_clk(i_clk), 
                        .i_rst_ni(i_rst_n), 
                        .RegWriteW(RegWriteW), 
                        .RDW(RDW), 
                        .InstrD(InstrD), 
                        .PCD(PCD), 
                        .PCPlus4D(PCPlus4D), 
                        .ResultW(ResultW), 
                        .RegWriteE(RegWriteE), 
                        .MemWriteE(MemWriteE), 
                        .br_unE(br_unE),
                        .opa_selE(opa_selE),
                        .opb_selE(opb_selE),
                        .ResultSrcE(ResultSrcE),
                        .ALUControlE(ALUControlE), 
                        .RS1_E(RS1_E), 
                        .RS2_E(RS2_E), 
                        .Imm_Gen_E(Imm_Gen_E), 
								.RS1_ADDR_E(RS1_ADDR_E),
								.RS2_ADDR_E(RS2_ADDR_E),
                        .RD_ADDR_E(RD_ADDR_E), 
                        .PCE(PCE), 
                        .PCPlus4E(PCPlus4E),
								.insn_vldE(insn_vldE)
                       );

    // Execute-Stage
    execute_cycle execute(
                        .i_clk(i_clk), 
                        .i_rst_n(i_rst_n), 
                        .RegWriteE(RegWriteE), 
                        .MemWriteE(MemWriteE),
								.insn_vldE(insn_vldE),
								.br_unE(br_unE),	
								.opa_selE(opa_selE),
								.opb_selE(opb_selE),
                        .ResultSrcE(ResultSrcE), 
                        .ALUControlE(ALUControlE), 
                        .RS1_E(RS1_E), 
                        .RS2_E(RS2_E), 
                        .Imm_Gen_E(Imm_Gen_E), 
                        .RD_ADDRE(RD_ADDR_E), 
                        .PCE(PCE), 
                        .PCPlus4E(PCPlus4E),
								.ResultW(ResultW),
								.ForwardA_E(ForwardAE),
								.ForwardB_E(ForwardBE),
                        .PCSrcE(PCSrcE), 
                        .RegWriteM(RegWriteM), 
                        .MemWriteM(MemWriteM), 
                        .ResultSrcM(ResultSrcM), 
                        .RD_ADDR_M(RD_ADDR_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM),
                        .PCTargetE(PCTargetE),
								.insn_vldM(insn_vldM)
                    );
    
    // Memory-Stage
    memory_cycle memory (
                        .i_clk(i_clk), 
                        .i_rst_n(i_rst_n), 
                        .RegWriteM(RegWriteM), 
                        .MemWriteM(MemWriteM), 
								.insn_vldM(insn_vldM),
                        .ResultSrcM(ResultSrcM), 
                        .RD_ADDR_M(RD_ADDR_M), 
                        .PCPlus4M(PCPlus4M), 
                        .WriteDataM(WriteDataM), 
                        .ALU_ResultM(ALU_ResultM), 
								.io_sw(io_sw),
                        .RegWriteW(RegWriteW), 
                        .ResultSrcW(ResultSrcW), 
                        .RD_ADDR_W(RD_ADDR_W), 
                        .PCPlus4W(PCPlus4W), 
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW),
								.insn_vldW(insn_vldW),
								.o_io_lcd(o_io_lcd), 
								.o_io_ledg(o_io_ledg), 
								.o_io_ledr(o_io_ledr),
								.o_io_hex_low(o_io_hex_low), 
								.o_io_hex_high(o_io_hex_high)
                    );

    // WriteBack-Stage
    write_cycle write (
                        .ResultSrcW(ResultSrcW), 
                        .PCPlus4W(PCPlus4W), 
								.insn_vldW(insn_vldW),
                        .ALU_ResultW(ALU_ResultW), 
                        .ReadDataW(ReadDataW), 
								.insn_vld(insn_vld),
                        .ResultW(ResultW)								
                    );
//forwarding
 	forwarding forwarding (
								.i_rst_n(i_rst_n), 
                        .RegWriteM(RegWriteM), 
                        .RegWriteW(RegWriteW), 
                        .RD_ADDR_M(RD_ADDR_M), 
                        .RD_ADDR_W(RD_ADDR_W), 
                        .Rs1_ADDR_E(RS1_ADDR_E), 
                        .Rs2_ADDR_E(RS2_ADDR_E), 
                        .ForwardAE(ForwardAE), 
                        .ForwardBE(ForwardBE) 	
);

// application stop-watch 	
	stop_watch stop_watch (
								.i_clk(i_clk),
								.i_rst_n(i_rst_n), 
								.start(i_io_sw[16]), 
								.stop(i_io_sw[15]),
								.sw(i_io_sw[5:0]),
								.outsegml1(o_io_hex_low[6:0]),
								.outsegm1(o_io_hex_low[30:24]), 
								.outsegm2(o_io_hex_high[6:0]),
								.outsegs1(o_io_hex_low[14:8]),
								.outsegs2(o_io_hex_low[22:16])
	);
endmodule : pipeline
