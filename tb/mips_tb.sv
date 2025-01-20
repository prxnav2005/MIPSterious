module mips_tb;
  logic clk, reset;
  logic [31:0] instr, readData;
  logic [31:0] pc, aluOut, writeData;
  logic memWrite, regWriteW;

  mips mips_inst(clk, reset, instr, readData, pc, aluOut, writeData, memWrite, regWriteW);

  initial begin
    clk = 0;
    reset = 1;
    instr = 32'h00000000;
    readData = 32'h00000000;
    #5 reset = 0;
    #10 instr = 32'h20020001;  // Example instruction
    #10 instr = 32'h20030002;  // Another example instruction
    #10 instr = 32'h08000003;  // Jump instruction
    #10 $finish;
  end

  always #5 clk = ~clk;
endmodule
