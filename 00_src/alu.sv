module alu 
	(
	//input declar
	input logic [31:0] i_operand_a,		//First operand for ALU operations.
	input logic [31:0] i_operand_b,		//Second operand for ALU operations.
	input logic [3:0] i_alu_op, 			//The operation to be performed.
	//output declar
	output logic [31:0] o_alu_data		//Result of the ALU operation.
	);
	 
	// internal signal declaring
	logic [31:0] not_a, not_b;
	logic [31:0] mux_0;
	logic [31:0] ADD, SUB, SLT, SLTU, XOR, OR, AND, SLL, SRL, SRA;
  
	// logic design 
	assign not_b = ~i_operand_b;
	assign not_a = ~i_operand_a;
	assign OR = i_operand_a | i_operand_b;	
	assign AND = i_operand_a & i_operand_b;
	assign XOR = (i_operand_a | i_operand_b) & (not_a | not_b);	
	assign ADD = i_operand_a + i_operand_b;
	assign SUB = i_operand_a + not_b + 1;
	assign SLT = ( SUB[31]) ? 32'h0000_0001 : 32'h0000_0000;
	assign SLTU = ( SUB[31]) ? 32'h0000_0001 : 32'h0000_0000;
	
	assign SRL = ( i_operand_b[4:0] == 5'd1 ) ? {1'b0, i_operand_a[31:1]} :
					 ( i_operand_b[4:0] == 5'd2 ) ? {2'b0, i_operand_a[31:2]} : ( i_operand_b[4:0] == 5'd3 ) ? {3'b0, i_operand_a[31:3]} :
					 ( i_operand_b[4:0] == 5'd4 ) ? {4'b0, i_operand_a[31:4]} : ( i_operand_b[4:0] == 5'd5 ) ? {5'b0, i_operand_a[31:5]} :
					 ( i_operand_b[4:0] == 5'd6 ) ? {6'b0, i_operand_a[31:6]} : ( i_operand_b[4:0] == 5'd7 ) ? {7'b0, i_operand_a[31:7]} :
					 ( i_operand_b[4:0] == 5'd8 ) ? {8'b0, i_operand_a[31:8]} : ( i_operand_b[4:0] == 5'd9 ) ? {9'b0, i_operand_a[31:9]} :
					 ( i_operand_b[4:0] == 5'd10 ) ? {10'b0, i_operand_a[31:10]} : ( i_operand_b[4:0] == 5'd11 ) ? {11'b0, i_operand_a[31:11]} :
					 ( i_operand_b[4:0] == 5'd12 ) ? {12'b0, i_operand_a[31:12]} : ( i_operand_b[4:0] == 5'd13 ) ? {13'b0, i_operand_a[31:13]} :
					 ( i_operand_b[4:0] == 5'd14 ) ? {14'b0, i_operand_a[31:14]} : ( i_operand_b[4:0] == 5'd15 ) ? {15'b0, i_operand_a[31:15]} :
					 ( i_operand_b[4:0] == 5'd16 ) ? {16'b0, i_operand_a[31:16]} : ( i_operand_b[4:0] == 5'd17 ) ? {17'b0, i_operand_a[31:17]} :
					 ( i_operand_b[4:0] == 5'd18 ) ? {18'b0, i_operand_a[31:18]} : ( i_operand_b[4:0] == 5'd19 ) ? {19'b0, i_operand_a[31:19]} :
					 ( i_operand_b[4:0] == 5'd20 ) ? {20'b0, i_operand_a[31:20]} : ( i_operand_b[4:0] == 5'd21 ) ? {21'b0, i_operand_a[31:21]} :
					 ( i_operand_b[4:0] == 5'd22 ) ? {22'b0, i_operand_a[31:22]} : ( i_operand_b[4:0] == 5'd23 ) ? {23'b0, i_operand_a[31:23]} :
					 ( i_operand_b[4:0] == 5'd24 ) ? {24'b0, i_operand_a[31:24]} : ( i_operand_b[4:0] == 5'd25 ) ? {25'b0, i_operand_a[31:25]} :
					 ( i_operand_b[4:0] == 5'd26 ) ? {26'b0, i_operand_a[31:26]} : ( i_operand_b[4:0] == 5'd27 ) ? {27'b0, i_operand_a[31:27]} :
					 ( i_operand_b[4:0] == 5'd28 ) ? {28'b0, i_operand_a[31:28]} : ( i_operand_b[4:0] == 5'd29 ) ? {29'b0, i_operand_a[31:29]} :
					 ( i_operand_b[4:0] == 5'd30 ) ? {30'b0, i_operand_a[31:30]} : ( i_operand_b[4:0] == 5'd31 ) ? {31'b0, i_operand_a[31]} : i_operand_a;
	
	assign SLL = ( i_operand_b == 5'd1 ) ? { i_operand_a[30:0], 1'b0} :
					 ( i_operand_b[4:0] == 5'd2 ) ? { i_operand_a[29:0], 2'b0 } : ( i_operand_b == 5'd3 ) ? { i_operand_a[28:0], 3'b0} :
					 ( i_operand_b[4:0] == 5'd4 ) ? { i_operand_a[27:0], 4'b0} : ( i_operand_b == 5'd5 ) ? { i_operand_a[26:0], 5'b0} :
					 ( i_operand_b[4:0] == 5'd6 ) ? { i_operand_a[25:0], 6'b0} : ( i_operand_b == 5'd7 ) ? { i_operand_a[24:0], 7'b0} :
					 ( i_operand_b[4:0] == 5'd8 ) ? { i_operand_a[23:0], 8'b0} : ( i_operand_b == 5'd9 ) ? { i_operand_a[22:0], 9'b0} :
					 ( i_operand_b[4:0] == 5'd10 ) ? { i_operand_a[21:0], 10'b0} : ( i_operand_b == 5'd11 ) ? { i_operand_a[20:0], 11'b0} :
					 ( i_operand_b[4:0] == 5'd12 ) ? { i_operand_a[19:0], 12'b0} : ( i_operand_b == 5'd13 ) ? { i_operand_a[18:0], 13'b0} :
					 ( i_operand_b[4:0] == 5'd14 ) ? { i_operand_a[17:0], 14'b0} : ( i_operand_b == 5'd15 ) ? { i_operand_a[16:0], 15'b0} :
					 ( i_operand_b[4:0] == 5'd16 ) ? { i_operand_a[15:0], 16'b0} : ( i_operand_b == 5'd17 ) ? { i_operand_a[14:0], 17'b0} :
					 ( i_operand_b[4:0] == 5'd18 ) ? { i_operand_a[13:0], 18'b0} : ( i_operand_b == 5'd19 ) ? { i_operand_a[12:0], 19'b0} :
					 ( i_operand_b[4:0] == 5'd20 ) ? { i_operand_a[11:0], 20'b0} : ( i_operand_b == 5'd21 ) ? { i_operand_a[10:0], 21'b0} :
					 ( i_operand_b[4:0] == 5'd22 ) ? { i_operand_a[9:0], 22'b0} : ( i_operand_b == 5'd23 ) ? { i_operand_a[8:0], 23'b0} :
					 ( i_operand_b[4:0] == 5'd24 ) ? { i_operand_a[7:0], 24'b0} : ( i_operand_b == 5'd25 ) ? { i_operand_a[6:0], 25'b0} :
					 ( i_operand_b[4:0] == 5'd26 ) ? { i_operand_a[5:0], 26'b0} : ( i_operand_b == 5'd27 ) ? { i_operand_a[4:0], 27'b0} :
					 ( i_operand_b[4:0] == 5'd28 ) ? { i_operand_a[3:0], 28'b0} : ( i_operand_b == 5'd29 ) ? { i_operand_a[2:0], 29'b0} :
					 ( i_operand_b[4:0] == 5'd30 ) ? { i_operand_a[1:0], 30'b0} : ( i_operand_b == 5'd31 ) ? { i_operand_a[0], 31'b0} : i_operand_a;
	
	assign SRA =  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd1 ) ) ? {32'hffff_ffff, i_operand_a[31:1]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd2 ) ) ? {32'hffff_ffff, i_operand_a[31:2]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd3 ) ) ? {32'hffff_ffff, i_operand_a[31:3]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd4 ) ) ? {32'hffff_ffff, i_operand_a[31:4]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd5 ) ) ? {32'hffff_ffff, i_operand_a[31:5]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd6 ) ) ? {32'hffff_ffff, i_operand_a[31:6]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd7 ) ) ? {32'hffff_ffff, i_operand_a[31:7]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd8 ) ) ? {32'hffff_ffff, i_operand_a[31:8]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd9 ) ) ? {32'hffff_ffff, i_operand_a[31:9]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd10 ) ) ? {32'hffff_ffff, i_operand_a[31:10]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd11 ) ) ? {32'hffff_ffff, i_operand_a[31:11]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd12 ) ) ? {32'hffff_ffff, i_operand_a[31:12]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd13 ) ) ? {32'hffff_ffff, i_operand_a[31:13]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd14 ) ) ? {32'hffff_ffff, i_operand_a[31:14]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd15 ) ) ? {32'hffff_ffff, i_operand_a[31:15]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd16 ) ) ? {32'hffff_ffff, i_operand_a[31:16]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd17 ) ) ? {32'hffff_ffff, i_operand_a[31:17]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd18 ) ) ? {32'hffff_ffff, i_operand_a[31:18]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd19 ) ) ? {32'hffff_ffff, i_operand_a[31:19]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd20 ) ) ? {32'hffff_ffff, i_operand_a[31:20]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd21 ) ) ? {32'hffff_ffff, i_operand_a[31:21]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd22 ) ) ? {32'hffff_ffff, i_operand_a[31:22]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd23 ) ) ? {32'hffff_ffff, i_operand_a[31:23]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd24 ) ) ? {32'hffff_ffff, i_operand_a[31:24]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd25 ) ) ? {32'hffff_ffff, i_operand_a[31:25]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd26 ) ) ? {32'hffff_ffff, i_operand_a[31:26]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd27 ) ) ? {32'hffff_ffff, i_operand_a[31:27]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd28 ) ) ? {32'hffff_ffff, i_operand_a[31:28]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd29 ) ) ? {32'hffff_ffff, i_operand_a[31:29]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd30 ) ) ? {32'hffff_ffff, i_operand_a[31:30]} :
					  (( i_operand_a[31]  == 1 ) & ( i_operand_b == 5'd31 ) ) ? {32'hffff_ffff, i_operand_a[31]} : 32'h0;
	assign mux_0 = ( i_alu_op [3:0] == 4'b0000 ) ? ADD : ( i_alu_op [3:0] == 4'b0001 ) ? SUB :
						( i_alu_op [3:0] == 4'b0010 ) ? SLT : ( i_alu_op [3:0] == 4'b0011 ) ? SLTU :
						( i_alu_op [3:0] == 4'b0100 ) ? XOR : ( i_alu_op [3:0] == 4'b0101 ) ? OR : 
						( i_alu_op [3:0] == 4'b0110 ) ? AND : ( i_alu_op [3:0] == 4'b0111 ) ? SLL :
						( i_alu_op [3:0] == 4'b1000 ) ? SRL : ( i_alu_op [3:0] == 4'b1001) ? SRA : 32'h0000_0000;
						
	assign o_alu_data = mux_0;
	
endmodule : alu

