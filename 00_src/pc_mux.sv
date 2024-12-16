module pc_mux(
	 input  logic pc_sel,
    input  logic [31:0] pc,
	 input  logic [31:0] o_alu_data,
    output logic [31:0] pc_next
);

    always @(*)
    begin
		if(pc_sel) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			pc_next <= o_alu_data;
		end
		else begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			pc_next <= pc + 4;
		end
    end
endmodule : pc_mux

