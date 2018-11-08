`timescale 1ps/1ps
module ALU(input [31:0]A,B,input [2:0]ALUOperation ,output reg [31:0] ALUResult,output zero);
    reg signed [31:0] High;
    reg signed[31:0] Low;
    always@(A,B,ALUOperation)begin
      High<=High;
      Low<=Low;
      case(ALUOperation)
        3'b010:ALUResult<=A+B;
        3'b110:ALUResult<=A-B;
        3'b000:ALUResult<=A&B;
        3'b001:ALUResult<=A|B;
        3'b100:{High,Low}<=A*B;
        3'b111:ALUResult<=A^B;
        3'b011:ALUResult<=Low;
        3'b101:ALUResult<=High;
    endcase
    end
    assign zero=(A-B)?0:1;
endmodule