module controller_tb;

  logic clk;
  logic [5:0] op, funct;
  logic regWriteD, memToRegD, memWriteD, aluSrcD, regDstD, branchD;
  logic [2:0] aluControlD;
  logic jump;

  controller dut(.clk(clk), .op(op), .funct(funct), .regWriteD(regWriteD), .memToRegD(memToRegD), .memWriteD(memWriteD), .aluSrcD(aluSrcD), .regDstD(regDstD), .branchD(branchD), .aluControlD(aluControlD), .jump(jump));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    op = 6'b000000; funct = 6'b100000; #10;
    op = 6'b100011; funct = 6'bxxxxxx; #10;
    op = 6'b101011; funct = 6'bxxxxxx; #10;
    op = 6'b000100; funct = 6'bxxxxxx; #10;
    op = 6'b001000; funct = 6'bxxxxxx; #10;
    op = 6'b000010; funct = 6'bxxxxxx; #10;
    op = 6'b111111; funct = 6'bxxxxxx; #10;
    $finish;
  end

endmodule
