module Register_5_bit(input ld, clk, input[4:0] in, output reg [4:0]out);
	always@(posedge clk)begin:loop
		if(ld) out = in;
	end	 
endmodule