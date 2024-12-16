module hazard_unit (
    input logic i_clk, rd_wren_w, br_taken
    input logic [31:0] instrW, instrD, instrE, instrM, 
    output logic stall_pc, StallF, StallD, FlushF, FLushD,
);
    assign instrW[19:15] = rs1_w;
    assign instrM[19:15] = rs1_M;
    assign instrW[24:20] = rs2_w;
    assign instrM[24:20] = rs2_M;
    assign instrE[19:25] = rs1_e;
    assign instrE[24:20] = rs2_e;
    assign instrW[11:7]  = rd;
    assign instrE[6:0] = opcode;
    always_ff @( posedge i_clk ) begin
        if ((rs1_e == rd || rs2_e == rd) && rd_wren_w == 1 && rd != 0 ) begin
           stall_pc     <= 1;
           StallF       <= 1;
           FLushD       <= 1;
        end
        else if (opcode == 7'b0000011 && (rs1_e == rd || rs2_e == rd) && rd != 0) begin
           stall_pc     <= 1;
           StallF       <= 1;
           FLushD       <= 1;
        end
        else if (br_taken == 1) begin
            FlushF <= 1;
            FLushD <= 1;
        end
        else begin
           stall_pc     <= 0;
           StallF       <= 0;
           FlushF       <= 0;
           StallD       <= 0;
           FLushD       <= 0;
        end
    end
endmodule