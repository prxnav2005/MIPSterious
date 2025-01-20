module signext_tb;
  logic [15:0] a;
  logic [31:0] y;

  signext uut(a, y);

  initial begin
    a = 16'b0000000000001010; // Positive number
    #10;
    a = 16'b1111111111111010; // Negative number
    #10;
    a = 16'b0000000000000000; // Zero value
    #10;
    a = 16'b1111111111111111; // All ones
    #10;
    $finish;
  end
endmodule
