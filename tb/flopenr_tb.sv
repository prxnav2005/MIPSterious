module flopenr_tb;

  logic clk, reset, en;
  logic [7:0] d;
  logic [7:0] q;

  flopenr #(8) dut(.clk(clk), .reset(reset), .en(en), .d(d), .q(q));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1; en = 0; d = 8'h00; #10;
    reset = 0; en = 1; d = 8'hAA; #10;
    $display("Data read: %h", q);
    en = 0; d = 8'h55; #10;
    $display("Data read: %h", q);
    en = 1; d = 8'hFF; #10;
    $display("Data read: %h", q);
    reset = 1; #10;
    $display("Data read after reset: %h", q);
    $finish;
  end

endmodule
