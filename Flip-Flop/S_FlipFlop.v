`include "JK_FLipFlop.v"

module S_FlipFlop(S, B, D, T, I, CLK);

    output S;
    input [11:0]B, [7:0]D, [7:0]T, I, CLK;

    wire j, k;
    assign j = D[7] & ~I & T[3] & B[0];
    assign k = 1'b0;

    JK_FLipFlop jkff(S, j, k, CLK);

endmodule