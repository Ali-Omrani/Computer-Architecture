module Ereg(input in, ld, clk, output reg out);
  always@(posedge clk)begin:load
    if(ld) out <= in;
end
endmodule
