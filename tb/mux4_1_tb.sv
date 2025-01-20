module mux4_tb;
  logic [7:0] d0, d1, d2, d3;
  logic [1:0] s;
  logic [7:0] y;

  mux4 #(8) uut(d0, d1, d2, d3, s, y);

  initial begin
    d0 = 8'b00000000; d1 = 8'b11111111; d2 = 8'b10101010; d3 = 8'b01010101; s = 2'b00;
    #10 s = 2'b01;
    #10 s = 2'b10;
    #10 s = 2'b11;
    #10 s = 2'b00;
    #10 $finish;
  end
endmodule
