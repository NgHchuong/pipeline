module display(
  input [3:0] bcd,
  output logic [6:0] s);
always @(bcd)
begin
      case(bcd)
        4'b0000 : s = 7'h40;
        4'b0001 : s = 7'h79;
        4'b0010 : s = 7'h24;
        4'b0011 : s = 7'h30;
        4'b0100 : s = 7'h19;
        4'b0101 : s = 7'h12;
        4'b0110 : s = 7'h02;
        4'b0111 : s = 7'h78;
        4'b1000 : s = 7'h00;
        4'b1001 : s = 7'h18;
      endcase
end
endmodule