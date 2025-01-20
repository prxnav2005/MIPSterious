module datapath_tb;

  logic clk, reset, MemtoRegD, AluSrcD, RegDstD, RegWriteD, branchD, jump, RegWriteW;
  logic [2:0] AluControlD;
  logic [31:0] PCF, instrD, ALUOutM, WriteDataM, instr, ReadDataE;
  logic MemWriteD;

  datapath dut(.clk(clk), .reset(reset), .MemtoRegD(MemtoRegD), .AluSrcD(AluSrcD), .RegDstD(RegDstD), .RegWriteD(RegWriteD), .branchD(branchD), .jump(jump), .AluControlD(AluControlD), .PCF(PCF), .instrD(instrD), .ALUOutM(ALUOutM), .WriteDataM(WriteDataM), .RegWriteW(RegWriteW), .instr(instr), .ReadDataE(ReadDataE), .MemWriteD(MemWriteD));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1; MemtoRegD = 0; AluSrcD = 0; RegDstD = 0; RegWriteD = 0; branchD = 0; jump = 0; AluControlD = 3'b000; instr = 32'h00000000; ReadDataE = 32'h00000000; MemWriteD = 0; #20;
    reset = 0; instr = 32'h8C130004; MemtoRegD = 1; AluSrcD = 1; RegDstD = 0; RegWriteD = 1; branchD = 0; jump = 0; AluControlD = 3'b010; #20;
    instr = 32'hAC140008; MemtoRegD = 0; AluSrcD = 1; RegDstD = 0; RegWriteD = 0; branchD = 0; jump = 0; AluControlD = 3'b010; #20;
    instr = 32'h00221820; MemtoRegD = 0; AluSrcD = 0; RegDstD = 1; RegWriteD = 1; branchD = 0; jump = 0; AluControlD = 3'b010; #20;
    instr = 32'h10220004; MemtoRegD = 0; AluSrcD = 0; RegDstD = 0; RegWriteD = 0; branchD = 1; jump = 0; AluControlD = 3'b110; #20;
    instr = 32'h08000004; MemtoRegD = 0; AluSrcD = 0; RegDstD = 0; RegWriteD = 0; branchD = 0; jump = 1; AluControlD = 3'b000; #20;
    $finish;
  end

endmodule
