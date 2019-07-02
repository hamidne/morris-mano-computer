module D_FlipFlopRST16(Q, D, CLK, Enable, RESET);

	input [15:0] D;
	output reg [15:0] Q;
	input CLK, Enable, RESET;

	always @(posedge CLK or posedge RESET)
		begin
			if(RESET)
				Q <= 1'b0;
			else if(Enable)
				Q <= D;
		end
	
endmodule