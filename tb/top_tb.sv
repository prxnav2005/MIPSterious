module top_tb;
  logic clk, reset;
  logic [31:0] writeData, dataAdr;
  logic memWrite;

  top uut(clk, reset, writeData, dataAdr, memWrite);

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
    #50;
    $finish;
  end
endmodule
