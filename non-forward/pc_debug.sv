	module pc_debug (
	//input 
	input logic [31:0] pc,
	//output
	output logic o_pc_debug
	);
	
	assign o_pc_debug = (pc != 32'h0000_0000) ? 1 : 0;
	endmodule : pc_debug