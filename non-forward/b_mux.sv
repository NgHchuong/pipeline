module b_mux(
    input logic opb_sel,
    input logic [31:0] imm_o,
    input logic [31:0] rs2_data,
    output logic [31:0] i_operand_b
);

    always @(*) begin
        if (opb_sel) begin
            // Nếu opb_sel = 1, chọn instr
            i_operand_b = imm_o;
        end else begin
            // Nếu opb_sel = 0, chọn rs2_data
            i_operand_b = rs2_data;
        end
    end
endmodule : b_mux