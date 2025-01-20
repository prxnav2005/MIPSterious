module mux2_tb;
  logic [7:0] d0, d1;
  logic s;
  logic [7:0] y;

  mux2 #(8) uut(d0, d1, s, y);

  initial begin
    d0 = 8'b00000000; d1 = 8'b11111111; s = 0;
    #10 d0 = 8'b10101010; d1 = 8'b01010101; s = 1;
    #10 d0 = 8'b00000000; d1 = 8'b11111111; s = 0;
    #10 d0 = 8'b11110000; d1 = 8'b00001111; s = 1;
    #10 $finish;
  end
endmodule
