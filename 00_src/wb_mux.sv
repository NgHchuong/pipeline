module wb_mux(
	 input  logic [1:0]  wb_sel,
    input  logic [31:0] o_alu_data,
	 input  logic [31:0] pc,
	 input  logic [31:0] o_ld_data,
    output logic [31:0] wb_data
);

    always @(*)
    begin
		if(wb_sel == 2'b00) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			wb_data <= pc + 4;
		end
		else if(wb_sel == 2'b01) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			wb_data <= o_alu_data;
		end
		else if(wb_sel == 2'b10) begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			wb_data <= o_ld_data;
		end
    end
endmodule : wb_mux

