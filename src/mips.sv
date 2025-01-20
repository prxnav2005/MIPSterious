module mips(input logic clk, reset, input logic [31:0] instr, readData, output logic[31:0] pc, aluOut, writeData, output logic memWrite, regWriteW);
  logic memToRegD, aluSrc, regDst, regWrite, jump, branch;
  logic [2:0] alucontrol;
  logic [31:0] instrD;
  
  controller c(clk, instrD[31:26], instrD[5:0], regWrite, memtoRegD, memWrite, aluSrc, regDst, branch, aluControl, jump);
  datapath dp(clk,reset,memToRegD,aluSrc,regDst,regWrite,branch, jump, aluControl, pc, instr, aluOut, writeData, readData, memWrite, instrD, regWriteW);
endmodule