`timescale 1ps/1ps
module RegisterFile(input clk,input[4:0] ReadRegister1,ReadRegister2,WriteRegister,input [31:0] WriteData,input RegWrite,output [31:0] ReadData1,ReadData2);
  reg[31:0] File[31:0];
  assign ReadData1=File[ReadRegister1];
  assign ReadData2=File[ReadRegister2];
  always@(posedge clk)begin
    File[0]<=0;
    if(RegWrite)begin
      File[WriteRegister]<=WriteData;
    end
  end
  endmodule