module forwarding(
	// input declaring
    input logic 		  i_rst_n, RegWriteM, RegWriteW,
    input logic  [4:0] RD_ADDR_M, RD_ADDR_W, RS1_ADDR_E, RS2_ADDR_E,
	// outout declaring
    output logic [1:0] ForwardAE, ForwardBE
 );   
    assign ForwardAE = (~i_rst_n) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_ADDR_M != 5'h00) & (RD_ADDR_M == RS1_ADDR_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_ADDR_W != 5'h00) & (RD_ADDR_W == RS1_ADDR_E)) ? 2'b01 : 2'b00;
                       
    assign ForwardBE = (~i_rst_n) ? 2'b00 : 
                       ((RegWriteM == 1'b1) & (RD_ADDR_M != 5'h00) & (RD_ADDR_M == RS2_ADDR_E)) ? 2'b10 :
                       ((RegWriteW == 1'b1) & (RD_ADDR_W != 5'h00) & (RD_ADDR_W == RS2_ADDR_E)) ? 2'b01 : 2'b00;

endmodule: forwarding
