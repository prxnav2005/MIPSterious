module hazard(input logic BranchD, MemToRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW, input logic [4:0] RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW, output logic stallF, stallD, ForwardAD, ForwardBD, FlushE, output logic [1:0] ForwardAE, ForwardBE, input clk, reset);
  
  logic [1:0] ForwardAE_t, ForwardBE_t;
  logic lwstall, branchStall, FlushE1;

  always@(*) begin
    ForwardAE_t = (RegWriteM & (RsE != 0) & (RsE == WriteRegM)) ? 2'b10 : (RegWriteW & (RsE != 0) & (RsE == WriteRegW)) ? 2'b01 : 2'b00;
    ForwardBE_t = (RegWriteM & (RtE != 0) & (RtE == WriteRegM)) ? 2'b10 : (RegWriteW & (RtE != 0) & (RtE == WriteRegW)) ? 2'b01 : 2'b00;
  end

  assign ForwardAD = RegWriteM & (RsD == WriteRegM) & (RsD != 0);
  assign ForwardBD = RegWriteM & (RtD == WriteRegM) & (RtD != 0);
  assign lwstall = MemToRegE & ((RtE == RsD) | (RtE == RtD));
  assign branchStall = (BranchD & RegWriteE & ((RsD == WriteRegE) | (RtD == WriteRegE))) | (BranchD & MemtoRegM & ((RsD == WriteRegM) | (RtD == WriteRegM)));

  flopenr #(1) regHaz1(~clk, reset, 1'b1, lwstall | branchStall, stallF);
  flopenr #(1) regHaz2(~clk, reset, 1'b1, lwstall | branchStall, stallD);
  flopenr #(1) regHaz3(~clk, reset, 1'b1, lwstall | branchStall, FlushE1);
  flopenr #(1) regHaz6(~clk, reset, 1'b1, FlushE1, FlushE);
  flopenr #(2) regHaz4(~clk, reset, 1'b1, ForwardAE_t, ForwardAE);
  flopenr #(2) regHaz5(~clk, reset, 1'b1, ForwardBE_t, ForwardBE);

endmodule
