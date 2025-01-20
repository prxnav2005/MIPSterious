// Code your design here
module controller(input logic clk, input logic [5:0] op, funct, output logic regWriteD, memToRegD, memWriteD, aluSrcD, regDstD, branchD, output logic [2:0] aluControlD, output jump);
  
  logic[1:0] aluOp;
  logic [8:0] controls;
  
  assign{regWriteD, regDstD, aluSrcD, branchD, memWriteD, memtoRegD, aluOp, jump} = controls;
  
  always@(*)
    case(op)
      6'b000000: controls <= 9'b110000100; // R-Type
      6'b100011: controls <= 9'b101001000; // LW
      6'b101011: controls <= 9'b001010000; // SW
      6'b000100: controls <= 9'b000100010; // BEQ
      6'b001000: controls <= 9'b101000000; // ADDI
      6'b000010: controls <= 9'b000000001; // J-Type
      default: controls <= 9'bxxxxxxxxx; // illegal value 
    endcase
  
  always@(*)
    casez({aluOp, funct})
      8'b00??????: AluControlD = 3'b010; // add
      8'b01??????: AluControlD = 3'b110; // subtract
      8'b1?100000: AluControlD = 3'b010; // add
      8'b1?100010: AluControlD = 3'b110; // subtract 
      8'b1?100100: AluControlD = 3'b000; // and 
      8'b1?100101: AluControlD = 3'b001; // or 
      8'b1?101010: AluControlD = 3'b111; // set less than
    endcase
endmodule





