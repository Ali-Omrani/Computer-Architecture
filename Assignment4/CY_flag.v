module CY_flag(input clk,in,ld,rst,comp,output reg out);
  reg val;
  always@(posedge clk) begin
    if(ld)begin
      out<=in;
      val<=in;
    end
    if(rst)begin
      out<=1'b0;
      val<=1'b0;
    end
    if(comp)begin 
      out<=~val;
      val<=~val;
    end
  end
endmodule
