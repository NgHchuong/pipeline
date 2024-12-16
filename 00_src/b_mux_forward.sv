module b_mux_forward(
			 input logic [31:0] in_a, in_b, in_c,
			 input logic [1:0] sel,
          output logic [31:0] out
);
   assign out = (sel == 2'b00) ? in_a : (sel == 2'b01) 
												  ? in_b : (sel == 2'b10) 
												  ? in_c : 32'h00000000;

endmodule : b_mux_forward
