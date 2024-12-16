module stop_watch(
    input  logic 		  i_clk, i_rst_n, start, stop, // SW 17: START COUNTING; SW 16: STOP COUNTING
	 input  logic [5:0] sw,									 // SET UP TIME: SW [5:4] MINUTES AND SW [3:0] SECONDS
    output logic [6:0] outsegml1,						 // DISPLAY TIME ON 7-SEGMENTS LED
    output logic [6:0] outsegm1, outsegm2,
    output logic [6:0] outsegs1,outsegs2
    );

	logic seconds;
	logic [3:0] ml, s0, s1, m0, m1, h0, h1;	
always_ff @(posedge seconds)
begin
	if (start)
	begin
	ml <= ml + 1;
	if (ml >= 4'h9)
	begin
		ml <= 0;
		s0 <= s0 +1;
	if(s0 >= 4'h9)
	begin
		s0 <= 0;
		s1 <= s1 +1;
		if(s1 >= 4'h5)
		begin
			s1 <= 0;
			m0 <= m0 +1;
			if(m0 >= 4'h9)
			begin
				m0 <= 0;
				m1 <= m1 +1;
			end
			else	if(m1 == 4'd5 && m0 == 4'd9 )
				begin
					ml <= 0;
					s0 <= 0;
					s1 <= 0;
					m0 <= 0;
					m1 <= 0;
				end
		end
	end
	end
	end


	if(i_rst_n)
		begin
			ml <= 0;
			s0 <= 0;
			s1 <= 0;
			m0 <= 0;
			m1 <= 0;	
		end	
	else if (stop || ( (s1 == sw[5:4]) && (s0 == sw[3:0]) ) )
		begin				
			ml <= ml;
			s0 <= s0;
			s1 <= s1;
			m0 <= m0;
			m1 <= m1;
		end	
	
end

delay d22(i_clk,seconds);
display dp5 (m1,outsegm2);

display dp4 (m0,outsegm1);

display dp3 (s1,outsegs1);

display dp2 (s0,outsegs2);

display dp1 (ml,outsegml1);

 endmodule

