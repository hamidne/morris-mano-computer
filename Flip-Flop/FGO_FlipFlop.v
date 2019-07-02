`include "JK_FLipFlop.v"

module FGO_FlipFlop(FGO, B, D, T, I, CLK);

    output FGO;
    input [11:0]B, [7:0]D, [7:0]T, I, CLK;

    wire j, k;
    assign j = 1'b0;
    assign k = D[7] & I & T[3] & B[10];

    JK_FLipFlop jkff(FGO, j, k, CLK);

endmodule