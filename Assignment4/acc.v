module acc(input clk,rst,input [11:0] in_acc,input in_cy,input ld_acc,ld_cy,CLA,CLC,CMA,CMC,RAR,RAL,ROT,IAC,output reg [11:0] out_acc,output reg out_cy ,output acc_zero);
  always@(posedge clk)begin
    if(rst)begin
      out_acc<=12'd0;
      out_cy<=1'd0;
    end
    if(ld_acc)begin
      out_acc<=in_acc;
    end
    if(ld_cy)begin
      out_cy<=in_cy;
    end
    if(CLA)
      out_acc<=12'd0;
    if(CLC)
      out_cy<=1'd0;
    if(CMA)begin
      out_acc<=~(out_acc);
    end 
    if(CMC)begin
      out_cy<=~(out_cy);
    end
    if(RAR) begin
      if(~ROT)  begin out_acc<=({out_cy, out_acc} >> 1); out_cy = out_acc[0]; end
      else  begin out_acc[6:0]<= {out_cy, out_acc} >> 2; out_cy <= out_acc[1]; out_acc[7]<= out_acc[0]; end
    end
    if(RAL) begin  
      if(~ROT) begin {out_cy,out_acc} <= out_acc << 1; out_acc[0]<= out_cy; end   
      else  begin {out_cy,out_acc} <= out_acc << 2; out_acc[1]<= out_cy; out_acc[0] <= out_acc[7]; end
    end
    if(IAC) begin
      out_acc<=(out_acc+1);
     end
  end
  assign acc_zero=(out_acc==1'b0)?1'b1:1'b0;
endmodule