module lsu (
	//input declar 
	  input logic i_clk,          			// Global clock, active on the rising edge.
	  input logic i_rst,         				// Global active reset.
	  input logic [31:0] i_lsu_addr,    	// Address for data read/write.
	  input logic [31:0] i_st_data, 			// Data to be stored.
	  input logic i_lsu_wren,          		// Write enable signal (1 if writing).
	  input logic [31:0] i_io_sw,   			// Input for switches. 
	//output declar
	  output logic [31:0] o_ld_data, 		// Data read from memory
	  output logic [31:0] o_io_ledr, 		// Output for red LEDs.
	  output logic [31:0] o_io_ledg, 		// Output for green LEDs.
	  output logic [31:0] o_io_lcd, 			// Output for the LCD register.	  	  
	  output logic [31:0] o_io_hex_low, 	//	Output for 7-segment from 3-0 displays.
	  output logic [31:0] o_io_hex_high, 	//	Output for 7-segment from 7-4 displays.
	  
	 //SRAM OUTPUT
	  output logic [17:0]   SRAM_ADDR,
	  inout  wire  [15:0]   SRAM_DQ  ,
	  output logic          SRAM_CE_N,
	  output logic          SRAM_WE_N,
	  output logic          SRAM_OE_N,
	  output logic          SRAM_LB_N,
	  output logic          SRAM_UB_N
);

  // Memory Map Addresses
  localparam ADDR_SW   = 32'h7800;
  localparam ADDR_LCD  = 32'h7030;
  localparam ADDR_LEDG = 32'h7010;
  localparam ADDR_LEDR = 32'h7000;
  localparam ADDR_HEX_LOW  = 32'h7020;
  localparam ADDR_HEX_HIGH = 32'h7024;
  localparam SRAM_MAX  = 32'h3FFF;
  localparam SRAM_MIN  = 32'h2000;

  // Internal registers for memory-mapped data
  logic [31:0] lcd_data, ledg_data, ledr_data, i_buffer;
  logic  [6:0] hex0_data, hex1_data, hex2_data, hex3_data, hex4_data, hex5_data, hex6_data, hex7_data;
  logic [31:0] i_WDATA, o_RDATA;
  logic [17:0] i_ADDR;
  logic [ 3:0] i_BMASK;
  logic        i_WREN, i_RDEN, o_ACK, flag;
  logic  [6:0] dis_hex0_data, dis_hex1_data, dis_hex2_data, dis_hex3_data, dis_hex4_data, dis_hex5_data, dis_hex6_data, dis_hex7_data;
  
  enum int unsigned { check = 0, write = 1, read = 2, wait_wr = 3, finish = 4, reset = 5 } p_state, n_state;
always_comb begin : next_state_logic
	  n_state = check;
	  case(p_state)
		check: n_state = (i_lsu_wren) ? write : read;
		write: n_state = (i_lsu_addr > SRAM_MAX) ? check : ((i_lsu_addr >= SRAM_MIN) && (i_lsu_addr <= SRAM_MAX )) ? wait_wr : finish;
		read: n_state = (i_lsu_addr > SRAM_MAX) ? check : ((i_lsu_addr >= SRAM_MIN) && (i_lsu_addr <= SRAM_MAX )) ? wait_wr : finish;
		wait_wr: n_state = o_ACK ? finish : wait_wr;
		finish : n_state = check;
		reset : n_state = check;
	  endcase
end

always_ff@(posedge i_clk or negedge i_rst) begin
	  if(~i_rst)
		 p_state <= reset;
	  else
		 p_state <= n_state;
end
	// RECALL SRAM CONTROLLER
  sram_IS61WV25616_controller_32b_3lr data_sram(
  .i_ADDR(i_ADDR),
  .i_WDATA(i_WDATA),
  .i_BMASK(i_BMASK), 
  .i_WREN(i_WREN),
  .i_RDEN(i_RDEN),
  .o_RDATA(o_RDATA), 
  .o_ACK(o_ACK),
  .SRAM_UB_N(SRAM_UB_N),
  .SRAM_LB_N (SRAM_LB_N),
  .SRAM_ADDR(SRAM_ADDR),
  .SRAM_CE_N (SRAM_CE_N),
  .SRAM_DQ (SRAM_DQ),
  .SRAM_OE_N(SRAM_OE_N),
  .SRAM_WE_N(SRAM_WE_N),
  .i_clk(i_clk), 
  .i_reset(i_rst)
  );

always_ff
begin
	case(p_state)
		reset: begin
				// Reset internal registers during reset
				lcd_data <= 32'h0;
				ledg_data <= 32'h0;
				ledr_data <= 32'h0;
				hex0_data <= 32'h0;
				hex1_data <= 32'h0;
				hex2_data <= 32'h0;
				hex3_data <= 32'h0;
				hex4_data <= 32'h0;
				hex5_data <= 32'h0;
				hex6_data <= 32'h0;
				hex7_data <= 32'h0;
				i_buffer  <= 32'h0;
				i_BMASK   <= 4'b0;
				end	
		check: begin 
			 flag = i_lsu_wren ? 1 : 0;
			 end
		write: begin
			 if (i_lsu_addr > SRAM_MAX) begin
      // Write data to memory-mapped registers based on address
					case(i_lsu_addr)
					ADDR_SW   : i_buffer  = i_io_sw;
					ADDR_LCD  : lcd_data  = i_st_data;
					ADDR_LEDG : ledg_data = i_st_data;
					ADDR_LEDR : ledr_data = i_st_data;
					ADDR_HEX_LOW: begin 
									 hex0_data = i_st_data[6:0];
									 hex1_data = i_st_data[14:8];
									 hex2_data = i_st_data[22:16];
									 hex3_data = i_st_data[30:24];
									 end
					ADDR_HEX_HIGH: begin
									hex4_data = i_st_data[6:0];
									hex5_data = i_st_data[14:8];
									hex6_data = i_st_data[22:16];
									hex7_data = i_st_data[30:24];
									end
					 default;    							
					endcase
				 end
			else if ((i_lsu_addr >= SRAM_MIN) && (i_lsu_addr <= SRAM_MAX) ) begin
			// WRITE TO SRAM
					i_WDATA = i_st_data;
					i_WREN  = 1;
					i_ADDR  = i_lsu_addr[17:0];
					i_RDEN  = 0;
					i_BMASK = 4'b1111;
				end
			end
		read: begin
				if (i_lsu_addr > SRAM_MAX) 
				begin
		 // Read data from memory-mapped registers based on address
					 case(i_lsu_addr)
						ADDR_SW   : o_ld_data = i_buffer;
						ADDR_LCD  : o_ld_data = lcd_data;
						ADDR_LEDG : o_ld_data = ledg_data;
						ADDR_LEDR : o_ld_data = ledr_data;
						ADDR_HEX_LOW: begin
										o_ld_data[6:0] = hex0_data;
										o_ld_data[14:8] = hex1_data;
										o_ld_data[22:16] = hex2_data;
										o_ld_data[30:24] = hex3_data;
						end
						ADDR_HEX_HIGH: begin 
										o_ld_data[6:0] = hex4_data;
										o_ld_data[14:8] = hex5_data;
										o_ld_data[22:16] = hex6_data;
										o_ld_data[30:24] = hex7_data;
						end
						default   : o_ld_data = 32'h0; 		// Default value for other addresses
					 endcase
				end
				else if ((i_lsu_addr >= SRAM_MIN) && (i_lsu_addr <= SRAM_MAX) ) begin
			// READ FROM SRAM
						i_WDATA = 32'h0;
						i_WREN  = 0;
						i_ADDR  = i_lsu_addr;
						i_RDEN  = 1;
						i_BMASK = 4'b1111;
				end
		end
		wait_wr: begin
			o_ld_data = 32'hzzzz_zzzz;
		end
		finish:begin
			o_ld_data = o_RDATA;
		end	
	endcase
end
 
  // Peripheral Outputs
  assign o_io_lcd  = lcd_data;
  assign o_io_ledg = ledg_data;
  assign o_io_ledr = ledr_data;
  assign o_io_hex_low   [7:0] = {0, dis_hex0_data};
  assign o_io_hex_low  [15:8] = {0, dis_hex1_data};
  assign o_io_hex_low [23:16] = {0, dis_hex2_data};
  assign o_io_hex_low [31:24] = {0, dis_hex3_data};
  assign o_io_hex_high  [7:0] = {0, dis_hex4_data};
  assign o_io_hex_high [15:8] = {0, dis_hex5_data};
  assign o_io_hex_high[23:16] = {0, dis_hex6_data};
  assign o_io_hex_high[31:24] = {0, dis_hex7_data};

endmodule : lsu
