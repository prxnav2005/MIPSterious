module imem_tb;
  logic [5:0] a;
  logic [31:0] rd;

  imem uut(a, rd);

  initial begin
    a = 6'b000000;
    #10 a = 6'b000001;
    #10 a = 6'b000010;
    #10 a = 6'b000011;
    #10 $finish;
  end
endmodule
