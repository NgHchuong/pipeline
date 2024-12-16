module branch_sel(
    input logic [31:0] instr,    
    input logic br_less,          
    input logic br_equal,         
    output logic br_taken        
);
    always_comb begin
        // Kiểm tra các điều kiện rẽ nhánh
        case(instr[6:0])  
            7'b1100011: begin  
                // Kiểm tra xem điều kiện rẽ nhánh có được thỏa mãn không
                if (br_less | br_equal)
                    br_taken = 1;                
                else
                    br_taken = 0;  
            end
            default: br_taken = 0; 
        endcase
    end
endmodule