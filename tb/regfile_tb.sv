module regfile_tb;
  logic clk, we3;
  logic [4:0] ra1, ra2, wa3;
  logic [31:0] wd3;
  logic [31:0] rd1, rd2;

  regfile uut(clk, we3, ra1, ra2, wa3, wd3, rd1, rd2);

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize inputs
    we3 = 0;
    ra1 = 5'b00000; ra2 = 5'b00001; wa3 = 5'b00010; wd3 = 32'hDEADBEEF;

    // Test Write Operation
    #10 we3 = 1; // Enable writing
    #10 we3 = 0; // Disable writing

    // Test Read Operation
    #10 ra1 = 5'b00010; ra2 = 5'b00001;
    #10 ra1 = 5'b00001; ra2 = 5'b00010;

    #10 $finish;
  end
endmodule
