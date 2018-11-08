`timescale 1ps/1ps
module Register(input ld, clk, start ,input[31:0] in, output reg [31:0]out);
	always@(posedge clk)begin:loop
	  if(start) out<=32'b00000000000000000000000000000000;
		else if(ld) out <= in;
		  
	end	 
endmodule