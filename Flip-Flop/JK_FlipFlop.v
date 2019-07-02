module JK_FlipFlop(
    output Q,
    input  J,
    input  K,
    input  CLK,
  );

  always @(posedge CLK) begin
    if(J==1'b0 && K==1'b1) begin
      Q <= 'b0;
    end
    else if(J==1'b1 && K==1'b0) begin
      Q <= 1'b1;
    end
    else if(J==1'b1 & K==1'b1) begin
      Q <= ~Q;
    end
  end

endmodule