module pc(
    input 	logic [0:0]  i_clk, i_rst,
    input 	logic [31:0] pc_next,
    output 	logic [31:0] pc
);

    always @(posedge i_clk)
    begin
		if (!i_rst) begin
        // Nếu tín hiệu reset không hoạt động (active low), đặt pc_addr về 0
			pc <= 32'b0;
			end 
		else begin
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			pc <= pc_next;
		end
    end
endmodule : pc

