module pc(
    input 	logic  i_clk, i_rst, stall_pc,
    input 	logic [31:0] pc_next,
    output 	logic [31:0] pc
);

    always @(posedge i_clk)
    begin
		if (!i_rst) begin
        // Nếu tín hiệu reset không hoạt động (active low), đặt pc_addr về 0
			pc <= 32'b0;
			end
        else if (stall_pc) begin
            pc <= pc;
        end 
        else begin  
        // Nếu không reset, cập nhật pc_addr với giá trị nxt_pc
			pc <= pc_next;
		end
    end
endmodule : pc

