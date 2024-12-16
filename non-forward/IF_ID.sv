`include "timescale.svh"
module IF_ID (
    input logic i_clk, i_rst, StallF, FlushF,
    input logic [31:0] instrF,
    input logic [31:0] pc_f,
    output logic [31:0] instrD,
    output logic [31:0] pcD
);
    always_ff @( posedge i_clk ) begin 
        if (!i_rst) begin
            instrD <= 0;
            pcD <=0;
        end
        else if (StallF) begin
            instrD <= instrD;
            pcD <= pcD;
        end
        else if (FlushF) begin
            instrD <= 0;
            pcD <= 0;
        end
        else begin
            instrD <= instrF;
            pcD <= pc_f;
        end
    end
endmodule