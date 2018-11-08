module AddressGen(input [4:0] page, input [6:0] in_addr, input [1:0] mode, output reg[11:0] address, output reg direct) ;
  always@(*)begin
    case(mode)
      2'b00:begin assign address={5'b00000,in_addr}; direct<=1'b1; end
      2'b01:begin assign address={page,in_addr}; direct=1; end
      2'b10:begin assign address={5'b00000,in_addr}; direct=0; end
      2'b11:begin assign address={page,in_addr}; direct=0; end
    endcase
  end
endmodule
