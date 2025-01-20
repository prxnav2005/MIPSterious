module sl2_tb;
  logic [31:0] a;
  logic [31:0] y;

  sl2 uut(a, y);

  initial begin
    a = 32'b00000000000000000000000000001010; // Simple value
    #10;
    a = 32'b00000000000000000000000011111111; // Another random value
    #10;
    a = 32'b11111111111111111111111111111111; // All ones
    #10;
    a = 32'b00000000000000000000000000000000; // Zero
    #10;
    $finish;
  end
endmodule
