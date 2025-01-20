module dmem_tb;

  logic clk, we;
  logic [31:0] a, wd, rd;

  dmem dut(.clk(clk), .we(we), .a(a), .wd(wd), .rd(rd));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    we = 0; a = 32'h00000000; wd = 32'h00000000; #20;
    a = 32'h00000004; wd = 32'h12345678; we = 1; #10;
    we = 0; a = 32'h00000004; #10;
    $display("Data read: %h", rd);
    a = 32'h00000008; wd = 32'hAABBCCDD; we = 1; #10;
    we = 0; a = 32'h00000008; #10;
    $display("Data read: %h", rd);
    $finish;
  end

endmodule
