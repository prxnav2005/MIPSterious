module hazard_tb;

  logic BranchD, MemToRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW;
  logic [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW;
  logic stallF, stallD, ForwardAD, ForwardBD, FlushE;
  logic [1:0] ForwardAE, ForwardBE;
  logic clk, reset;

  // Instantiate the DUT
  hazard dut(
    .BranchD(BranchD), .MemToRegE(MemToRegE), .RegWriteE(RegWriteE),
    .MemtoRegM(MemtoRegM), .RegWriteM(RegWriteM), .RegWriteW(RegWriteW),
    .RsD(RsD), .RtD(RtD), .RsE(RsE), .RtE(RtE),
    .WriteRegE(WriteRegE), .WriteRegM(WriteRegM), .WriteRegW(WriteRegW),
    .stallF(stallF), .stallD(stallD), .ForwardAD(ForwardAD), .ForwardBD(ForwardBD),
    .FlushE(FlushE), .ForwardAE(ForwardAE), .ForwardBE(ForwardBE),
    .clk(clk), .reset(reset)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initial state
    reset = 1;
    BranchD = 0;
    MemToRegE = 0;
    RegWriteE = 0;
    MemtoRegM = 0;
    RegWriteM = 0;
    RegWriteW = 0;
    RsD = 5'd0; RtD = 5'd0;
    RsE = 5'd0; RtE = 5'd0;
    WriteRegE = 5'd0; WriteRegM = 5'd0; WriteRegW = 5'd0;
    #10;

    reset = 0;
    
    // Test case 1: No hazard, no forwarding, no stalls
    RsD = 5'd1; RtD = 5'd2;
    RsE = 5'd3; RtE = 5'd4;
    #10;
    
    // Test case 2: Data hazard with forwarding
    RegWriteM = 1; WriteRegM = 5'd1;
    #10;

    // Test case 3: Data hazard with stall
    MemToRegE = 1; RtE = 5'd2; RsD = 5'd2; RtD = 5'd2;
    #10;

    // Test case 4: Branch hazard with stall
    BranchD = 1; RegWriteE = 1; WriteRegE = 5'd3; RsD = 5'd3;
    #10;

    // Test case 5: Flush for branch instruction
    #10;
    
    $finish;
  end

endmodule
