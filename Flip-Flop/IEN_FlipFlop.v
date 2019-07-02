`include "JK_FLipFlop.v"

module IEN_FlipFlop(IEN, D, T, B, I, R, CLK);

    output IEN;
    input [7:0]D, [7:0]T, [7:0]B, I, R, CLK;

    wire p, j, k, k1, k2;

    assign p = D[7] & I & T[3];
    assign j = p & B[7];

    assign k1 = p & B[6];
    assign k2 = R & T[2];

    assign k = k1 | k2;

    JK_FLipFlop jkff(IEN, j, k, CLK);

endmodule