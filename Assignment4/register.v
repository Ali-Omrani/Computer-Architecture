module register #(parameter size=32)(input clk,ld,reset,input [size-1:0] data,output reg[size-1:0] out);
  always@(posedge clk,posedge reset)begin
    if(reset)
      out<={(size){1'b0}};
   else if(ld)
      out<=data;
    end
endmodule 
