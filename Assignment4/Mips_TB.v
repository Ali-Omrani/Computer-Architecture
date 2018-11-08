module Mips_TB();
  reg clk ,rst;
  wire [31:0] ALU_out;
  initial begin 
  clk=0; #200  
  rst=1; #200
  clk=1;   #200
  rst=0; 
  clk=0; repeat (600) #200 clk=~clk;   end
  Mips mips(clk,rst);
endmodule