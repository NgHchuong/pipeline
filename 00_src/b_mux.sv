module b_mux(
	 input  logic opb_sel,
    input  logic [31:0] instr_gen,
	 input  logic [31:0] rs2_data,
    output logic [31:0] i_operand_b
);

    always @(*)
    begin
		if(opb_sel) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			i_operand_b <= instr_gen;
		end
		else begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			i_operand_b <= rs2_data;
		end
    end
endmodule : b_mux

