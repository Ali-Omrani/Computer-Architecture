module Devider_Tb();
	
reg [9:0]Dividend=10'b0000100010;
	
reg [4:0]Divisor=5'b00101;	
	
wire [4:0]Quotient;
	
reg clk,start,reset;
		
Devider devider(clk,start,reset,Dividend,Divisor,Quotient);

initial begin   clk=0; repeat (200) #200 clk=~clk;   end
initial begin reset=0; start=0; #1000 start=1; #1000 start=0; end 
endmodule