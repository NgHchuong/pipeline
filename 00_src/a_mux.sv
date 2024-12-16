module a_mux(
	 input  logic opa_sel,
    input  logic [31:0] pc,
	 input  logic [31:0] rs1_data,
    output logic [31:0] i_operand_a
);

    always @(*)
    begin
		if(opa_sel) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			i_operand_a <= pc;
		end
		else begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			i_operand_a <= rs1_data;
		end
    end
endmodule : a_mux

