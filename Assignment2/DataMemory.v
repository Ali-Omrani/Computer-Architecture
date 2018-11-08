`timescale 1ns/1ns
module DataMemory(input clk,input [31:0]Address,input [31:0] WriteData,input MemWrite,MemRead,output reg[31:0] ReadData);
  reg [7:0] MEM [4095:0];
  initial begin
  		{MEM[1000],MEM[1001],MEM[1002],MEM[1003]} = 32'd 1;
		{MEM[1004],MEM[1005],MEM[1006],MEM[1007]} = 32'd 2;
		{MEM[1008],MEM[1009],MEM[1010],MEM[1011]} = 32'd 3;
		{MEM[1012],MEM[1013],MEM[1014],MEM[1015]} = 32'd 4;
		{MEM[1016],MEM[1017],MEM[1018],MEM[1019]} = 32'd 5;
		{MEM[1020],MEM[1021],MEM[1022],MEM[1023]} = 32'd 6;
		{MEM[1024],MEM[1025],MEM[1026],MEM[1027]} = 32'd 7;
		{MEM[1028],MEM[1029],MEM[1030],MEM[1031]} = 32'd 44;
		{MEM[1032],MEM[1033],MEM[1034],MEM[1035]} = 32'd 9;
		{MEM[1036],MEM[1037],MEM[1038],MEM[1039]} = 32'd 10;
		{MEM[1040],MEM[1041],MEM[1042],MEM[1043]} = 32'd 1;
		{MEM[1044],MEM[1045],MEM[1046],MEM[1047]} = 32'd 2;
		{MEM[1048],MEM[1049],MEM[1050],MEM[1051]} = 32'd 3;
		{MEM[1052],MEM[1053],MEM[1054],MEM[1055]} = 32'd 4;
		{MEM[1056],MEM[1057],MEM[1058],MEM[1059]} = 32'd 5;
		{MEM[1060],MEM[1061],MEM[1062],MEM[1063]} = 32'd 6;
		{MEM[1064],MEM[1065],MEM[1066],MEM[1067]} = 32'd 7;
		{MEM[1068],MEM[1069],MEM[1070],MEM[1071]} = 32'd 20;
		{MEM[1072],MEM[1073],MEM[1074],MEM[1075]} = 32'd 9;
		{MEM[1076],MEM[1077],MEM[1078],MEM[1079]} = 32'd 10;
  end
  always@(*)
      ReadData=(MemRead)?{MEM[Address],MEM[Address+1],MEM[Address+2],MEM[Address+3]}:'x;
  always@(posedge clk)
  if(MemWrite)
    {MEM[Address],MEM[Address+1],MEM[Address+2],MEM[Address+3]}<=WriteData;
endmodule
