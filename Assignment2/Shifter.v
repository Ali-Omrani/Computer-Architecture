`timescale 1ps/1ps
module Shifter(input [31:0]in,output [31:0] out);
  assign out=in<<2;
endmodule