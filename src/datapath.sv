module datapath(input logic clk, reset, MemtoRegD, AluSrcD, RegDstD, RegWriteD, branchD, jump,
                input logic [2:0] AluControlD, output logic [31:0] PCF, instrD, ALUOutM, WriteDataM, 
                output logic RegWriteW, input logic [31:0] instr, ReadDataE, MemWriteD);

    // Instantiate hazard control unit
    logic stallF, stallD, ForwardAD, ForwardBD;
    logic[1:0] ForwardAE, ForwardBE; 
    hazard haz(branchD, MemtoRegE, RegWriteE, MemtoRegM, RegWriteM, RegWriteW, RsD, RtD, RsE, RtE, 
               WriteRegE, WriteRegM, WriteRegW, stallF, stallD, ForwardAD, ForwardBD, flush_e, ForwardAE, 
               ForwardBE, clk, reset);

    // PC and Register logic
    logic[31:0] PCPlus4F, ResultW, pcen2;
    logic EqualD, PCSrcD;  
    logic[4:0] RsD, RtD, RdD; 
    logic[31:0] SignImmD, SignImmE, PCBranchD, pcen; 

    mux2 #(32) adr_mux(PCPlus4F, PCBranchD, PCSrcD, pcen);
    mux2 #(32) adr_mux2(pcen, PCPJumpD, jump, pcen2);
    flopenr #(32) regF(clk, reset, ~stallF, pcen2, PCF);
    assign PCPlus4F = PCF + 4; 

    // Decode Registers
    logic[31:0] PCPlus4D; 
    flopenr #(32) regD1(clk, reset | PCSrcD_ext, ~stallD, instr, instrD);
    flopenr #(32) regD2(clk, reset | PCSrcD_ext, ~stallD, PCPlus4F, PCPlus4D);
    
    // MUX and comparison logic
    logic[31:0] rd1_comp, rd2_comp, RD1, RD2; 
    regfile rf(clk, RegWriteW, instrD[25:21], instrD[20:16], WriteRegW, ResultW, RD1, RD2); 
    mux2 #(32) comp_mux_1(RD1, ALUOutM, ForwardAD, rd1_comp);
    mux2 #(32) comp_mux_2(RD2, ALUOutM, ForwardBD, rd2_comp);
    assign EqualD = (rd1_comp == rd2_comp); 
    assign PCSrcD = EqualD & branchD; 

    // Additional Logic for PC Source
    logic PCSrcD_ext; 
    flopenr #(1) regfix(~clk, reset, 1'b1, PCSrcD | jump, PCSrcD_ext); 
    assign RsD = instrD[25:21];
    assign RtD = instrD[20:16];
    assign RdD = instrD[15:11];
    assign SignImmD = {{16{instrD[15]}}, instrD[15:0]};
    assign PCBranchD = (SignImmD << 2) + PCPlus4D; 

    // Jump Logic
    logic[31:0] PCPJumpD; 
    assign PCPJumpD = {PCPlus4D[31:4], instrD[25:0]<<2}; 

    // Execute Registers and ALU logic
    logic RegWriteE, MemtoRegE, MemWriteE, AluSrcE, RegDstE;
    logic[2:0] AluControlE; 
    logic[31:0] RD1_E, RD2_E; 
    logic[4:0] RsE, RtE, RdE;
    logic reset_exe_reg; 
    flopenr #(1) regE1(clk, reset | flush_e | jump2, 1'b1, RegWriteD, RegWriteE);
    flopenr #(1) regE2(clk, reset, 1'b1, MemtoRegD, MemtoRegE);
    flopenr #(1) regE3(clk, reset | flush_e | jump2, 1'b1, MemWriteD, MemWriteE);
    flopenr #(3) regE4(clk, reset, 1'b1, AluControlD, AluControlE);
    flopenr #(1) regE5(clk, reset, 1'b1, AluSrcD, AluSrcE);
    flopenr #(1) regE6(clk, reset, 1'b1, RegDstD, RegDstE);
    flopenr #(32) regE7(clk, reset, 1'b1, RD1, RD1_E);
    flopenr #(32) regE8(clk, reset, 1'b1, RD2, RD2_E);
    flopenr #(5) regE9(clk, reset | flush_e | jump2, 1'b1, RsD, RsE);
    flopenr #(5) regE10(clk, reset | flush_e | jump2, 1'b1, RtD, RtE);
    flopenr #(5) regE11(clk, reset | flush_e | jump2, 1'b1, RdD, RdE);
    flopenr #(32) regE12(clk, reset, 1'b1, SignImmD, SignImmE);
    flopenr #(1) regE13(clk, reset, 1'b1, jump, jump2); 

    // ALU Execution
    logic[31:0] SrcAE, SrcBE, WriteDataE, ALUoutE; 
    logic zero;
    logic[4:0] WriteRegE; 
    mux4 #(32) srcA_mux(RD1_E, ResultW, ALUOutM, 32'b0, ForwardAE, SrcAE);
    mux4 #(32) srcB_mux(RD2_E, ResultW, ALUOutM, 32'b0, ForwardBE, WriteDataE);
    mux2 #(32) srcB_mux2(WriteDataE, SignImmE, AluSrcE, SrcBE);
    alu32 alu(SrcAE, SrcBE, AluControlE, ALUoutE, zero);
    mux2 #(5) regDst_mux(RtE, RdE, RegDstE, WriteRegE);

    // Memory Registers
    logic[4:0] WriteRegM; 
    logic RegWriteM, MemtoRegM, MemWriteM; 
    flopenr #(1) regM1(clk, reset, 1'b1, RegWriteE, RegWriteM);
    flopenr #(1) regM2(clk, reset, 1'b1, MemtoRegE, MemtoRegM);
    flopenr #(1) regM3(clk, reset, 1'b1, MemWriteE, MemWriteM);
    flopenr #(32) regM4(clk, reset, 1'b1, ALUoutE, ALUOutM);
    flopenr #(32) regM5(clk, reset, 1'b1, WriteDataE, WriteDataM);
    flopenr #(5) regM6(clk, reset, 1'b1, WriteRegE, WriteRegM);

    // Writeback Logic
    logic[31:0] ReadDataW, ALUOutW; 
    logic MemtoRegW; 
    flopenr #(1) regW1(clk, reset, 1'b1, RegWriteM, RegWriteW);
    flopenr #(1) regW2(clk, reset, 1'b1, MemtoRegM, MemtoRegW);
    flopenr #(32) regW4(clk, reset, 1'b1, ReadDataE, ReadDataW);
    flopenr #(32) regW5(clk, reset, 1'b1, ALUOutM, ALUOutW);
    flopenr #(5) regW6(clk, reset, 1'b1, WriteRegM, WriteRegW);

    mux2 #(32) writeback_mux(ALUOutW, ReadDataW, MemtoRegW, ResultW);

endmodule
