`include "JK_FLipFlop.v"

module R_FlipFlop(R, T, IEN, FGI, FGO, CLK);

    inout R;
    input [7:0]T, I, IEN, FGI, FGO, CLK;

    wire j, k;
    assign j = R & T[2];
    assign k = ~T[0] & ~T[1] & ~T[2] & IEN & (FGI | FGO);

    JK_FLipFlop jkff(R, j, k, CLK);

endmodule