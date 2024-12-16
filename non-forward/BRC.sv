module BRC (
 //input
  input logic [31:0] i_rs1_data, 	// Data from the first register.
  input logic [31:0] i_rs2_data,  	// Data from the second register.
  input logic i_br_un,  				// Comparison mode (1 if signed, 0 if unsigned).
 //output
  output logic br_less, 				//	Output is 1 if rs1 < rs2
  output logic br_equal  				// Output is 1 if rs1 = rs2
);

 
 // Internal signal declaring
 logic c;
 logic [31:0] sub;
 assign {c,sub} = i_rs1_data + (~i_rs2_data) + 1;
always @(*) begin
    // Initialize outputs to 0
    br_less = 0;
    br_equal = 0;
   // Unsigned comparison
    if (i_br_un) begin
		if ( c )begin
				br_less  = 1;
				br_equal = 0;
		end
		else if ((c == 0) & (sub == 0)) begin
				br_less  = 0;
				br_equal = 1;
		end
		else begin
				br_less  = 0;
				br_equal = 0;
		end     
    end
    else begin
    //Signed comparison
		  if (~sub[31]) begin
            br_less  = 1;
				br_equal = 0;
        end
        if ((sub == 32'b0)) begin
            br_equal = 1;
				br_less  = 0;
        end
		  else begin
				br_less  = 0;
				br_equal = 0;
		  end
    end
end
endmodule : BRC
