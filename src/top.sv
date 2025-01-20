// Code your design here
module top(input logic clk, reset, output logic [31:0] writeData, dataAdr, output logic memWrite)
  
  logic [31:0] pc, instr, readData;
  mips MIPS(clk,reset,pc,instr,memWrite,dataAdr,writeData,readData,regWriteW);
  imem IMEM(pc[7:2], instr);
  dmem DMEM(clk,regWriteW,dataAdr,writeData,readData);
endmodule

