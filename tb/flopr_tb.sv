module flopr_tb;

  logic clk, reset;
  logic [7:0] d;
  logic [7:0] q;

  flopr #(8) dut(.clk(clk), .reset(reset), .d(d), .q(q));

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1; d = 8'h00; #10;
    reset = 0; d = 8'hAA; #10;
    $display("Data read: %h", q);
    d = 8'h55; #10;
    $display("Data read: %h", q);
    d = 8'hFF; #10;
    $display("Data read: %h", q);
    reset = 1; #10;
    $display("Data read after reset: %h", q);
    $finish;
  end

endmodule
