module alu32_tb;

  logic [31:0] A, B, Y;
  logic [2:0] F;
  logic zero;

  alu32 dut(.A(A), .B(B), .F(F), .Y(Y), .zero(zero));

  initial begin
    A = 32'hFFFFFFFF; B = 32'h00000000; F = 3'b000; #10;
    A = 32'h12345678; B = 32'h87654321; F = 3'b001; #10;
    A = 32'h0000FFFF; B = 32'hFFFF0000; F = 3'b010; #10;
    A = 32'h80000000; B = 32'h80000000; F = 3'b011; #10;
    A = 32'h00000000; B = 32'h00000000; F = 3'b100; #10;
    $finish;
  end

endmodule
