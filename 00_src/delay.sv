	module delay (
		input i_clk,
		output logic seconds
	);

	logic [31:0] count;

	always @(posedge i_clk) begin
	if (count <= 2499999) begin
		count = count + 1'b1;
		end
	else begin
		count = 0;
		seconds = ~seconds;
	end
	end
	endmodule