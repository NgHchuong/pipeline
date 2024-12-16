module memory_cycle (
 // input declaring
    input logic 		  i_clk, i_rst_n, RegWriteM, MemWriteM, insn_vldM, 
    input logic  [1:0] ResultSrcM,
    input logic  [4:0] RD_ADDR_M, 
    input logic [31:0] PCPlus4M, WriteDataM, ALU_ResultM,
    input logic [31:0] i_io_sw,   // 32-bit data switches
  
 //output declaring
    output logic        RegWriteW, insn_vldW, 
    output logic  [1:0] ResultSrcW, 
    output logic  [4:0] RD_ADDR_W,
    output logic [31:0] PCPlus4W, ALU_ResultW, ReadDataW,
	 output logic [31:0] o_io_lcd,  		 // 32-bit data drive LCD
  	 output logic [31:0] o_io_ledg, 		 // 32-bit data drive green LEDs
  	 output logic [31:0] o_io_ledr,      // 32-bit data drive red LEDs
  	 output logic [31:0] o_io_hex_low,   // 32-bit data drive 7-segment LEDs 
	 output logic [31:0] o_io_hex_high   // 32-bit data drive 7-segment LEDs 

);
    // Declaring wires
    logic [31:0] ReadDataM;

    // Declaring buffers
    logic		  insn_vld_t, RegWriteM_t; 
    logic  [1:0] ResultSrcM_t;
    logic  [4:0] RD_ADDR_M_t;
    logic [31:0] PCPlus4M_t, ALU_ResultM_t, ReadDataM_t;

    // Declaration of Module Initiation
    lsu lsu (
	.i_clk(i_clk),
	.i_rst(i_rst_n),
	.i_lsu_addr(ALU_ResultM),
	.i_st_data(WriteDataM),
	.i_lsu_wren(MemWriteM),
	.i_io_sw(i_io_sw),
	.o_ld_data(ReadDataM),
	.o_io_lcd(o_io_lcd), 
	.o_io_ledg(o_io_ledg), 
	.o_io_ledr(o_io_ledr),
	.o_io_hex_low(o_io_hex_low), 
	.o_io_hex_high(o_io_hex_high)
	);

    // Memory Stage Register Logic
    always_ff@(posedge i_clk or negedge i_rst_n) begin
        if (~i_rst_n) begin
				insn_vld_t     <= 1'b0;
            RegWriteM_t    <= 1'b0; 
            ResultSrcM_t   <= 2'b0;
            RD_ADDR_M_t    <= 5'h0;
            PCPlus4M_t     <= 32'h0; 
            ALU_ResultM_t  <= 32'h0; 
            ReadDataM_t    <= 32'h0;
        end
        else begin
				insn_vld_t    <= insn_vldM;
            RegWriteM_t   <= RegWriteM; 
            ResultSrcM_t  <= ResultSrcM;
            RD_ADDR_M_t   <= RD_ADDR_M;
            PCPlus4M_t    <= PCPlus4M; 
            ALU_ResultM_t <= ALU_ResultM; 
            ReadDataM_t   <= ReadDataM;
        end
    end 

    // Declaration of output assignments
    assign RegWriteW   = RegWriteM_t;
    assign ResultSrcW  = ResultSrcM_t;
    assign RD_ADDR_W   = RD_ADDR_M_t;
    assign PCPlus4W    = PCPlus4M_t;
    assign ALU_ResultW = ALU_ResultM_t;
    assign ReadDataW   = ReadDataM_t;
	 assign insn_vldW   = insn_vld_t;

endmodule : memory_cycle
