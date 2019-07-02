`include "JK_FLipFlop.v"

module FGI_FlipFlop(FGI, B, D, T, I, CLK);

    output FGI;
    input [11:0]B, [7:0]D, [7:0]T, I, CLK;

    wire j, k;
    assign j = 1'b0;
    assign k = D[7] & I & T[3] & B[11];

    JK_FLipFlop jkff(FGI, j, k, CLK);

endmodule