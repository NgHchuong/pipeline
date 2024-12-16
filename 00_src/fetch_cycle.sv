module fetch_cycle(
	//input declaring
	input logic i_clk,
	input logic i_rst_n,
	input logic PCSrcE,
	input logic [31:0] PCTargetE,
	//output declaring
	output logic [31:0] InstrD,
	output logic [31:0] PCD, 
	output logic [31:0] PCPlus4D
);

//Declaring interim wires
logic [31:0] PCF, PCPlus4F;
logic [31:0] InstrF;

//Declaring buffers
logic [31:0] InstrF_t;
logic[31:0] PCF_t, PCPlus4F_t;

//modules
 pc_mux pc_mux(
 	.pc(PCPlus4F),
 	.o_alu_data(PCTargetE),
 	.pc_sel(PCSrcE),
 	.pc_next(PCF)
 );

 pc pc(
	.i_clk(i_clk),
	.i_rst(i_rst_n),
	.pc_next(PCF),
	.pc(PCPlus4F)
 );

 imem imem(
 	.rst_ni(rst_ni),
 	.i_raddr(PCPlus4F),
 	.o_rdata(InstrF)	
 );
 //Register of fetch_cycle
always_ff@(posedge i_clk or negedge i_rst_n) begin
        if(~i_rst_n) begin
            InstrF_t   <= 32'b0;
            PCF_t      <= 32'b0;
            PCPlus4F_t <= 32'b0;
        end
        else begin
            InstrF_t   <= InstrF;
            PCF_t      <= PCF;
            PCPlus4F_t <= PCPlus4F;
        end
    end
 // Assigning Registers to the decode_cycle
     assign  InstrD   = (~i_rst_n) ? 32'b0 : InstrF_t;
     assign  PCD      = (~i_rst_n) ? 32'b0 : PCF_t;
     assign  PCPlus4D = (~i_rst_n) ? 32'b0 : PCPlus4F_t;

    endmodule : fetch_cycle
 
