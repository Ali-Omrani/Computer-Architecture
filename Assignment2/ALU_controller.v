`timescale 1ps/1ps
module ALU_controller(input [5:0]func,input [2:0] ALUOp, output reg [2:0] ALUOperation);
  always@(func,ALUOp)begin
    if(ALUOp==3'b000)
      ALUOperation=3'b010;
    else if(ALUOp==3'b001)
      ALUOperation=3'b110;
    else if(ALUOp==3'b100)
      ALUOperation=3'b000;
    else if(ALUOp==3'b110)
      ALUOperation=3'b001;
    else if(ALUOp==3'b111)
      ALUOperation=3'b111;
      
    else if(ALUOp==3'b010)
      case(func)
        6'b100000:ALUOperation=3'b010;
        6'b100010:ALUOperation=3'b110;
        6'b100100:ALUOperation=3'b000;
        6'b100101:ALUOperation=3'b001;
        6'b101010:ALUOperation=3'b111;
        6'b011000:ALUOperation=3'b100;
        6'b010000:ALUOperation=3'b101;
        6'b010000:ALUOperation=3'b011;
      endcase
  else
    ALUOperation = 3'b010;
    
  end
endmodule