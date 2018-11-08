module ALU(input[11:0] a,b,input alu_op ,output[11:0] result,output carry_out, zero);
        assign {carry_out,result} = (alu_op == 1'b0) ? (a + b) : 
                                    (alu_op == 1'b1) ? {1'b0,(a & b)} : 'Z;
			  assign zero = (result == 12'd0) ? 1'b1 : 1'b0;
        
endmodule 