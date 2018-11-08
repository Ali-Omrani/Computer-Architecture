`timescale 1ps/1ps
module mips_tb();
  reg clk ,start;
  wire [31:0] ALU_out;
  initial begin 
  clk=0; #200  
  start=1; #200
  clk=1;   #200
  start=0; 
  clk=0; repeat (600) #200 clk=~clk;   end
  mips MIPS(clk,start,ALU_out);
endmodule 
