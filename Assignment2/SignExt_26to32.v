`timescale 1ps/1ps
module SignExt_26to32(input [25:0]in,output reg[31:0] out);
  always@(in)
  out=(in[25])?{6'b111111,in}:{6'b000000,in};
endmodule
