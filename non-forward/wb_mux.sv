module wb_mux (
	input logic [12:0] pc,
	input logic [31:0] alu_data,
    input logic [31:0] ld_data,
	input logic [1:0] wb_sel,
	output logic [31:0] wb_data
);

	assign wb_data = (WBsel == 2'h0) ? ld_data :
	                 (WBsel == 2'h1) ? alu_data  :
						(WBsel == 2'h2) ? pc  : pc ;

endmodule