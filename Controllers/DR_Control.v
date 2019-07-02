module DR_Control(Load, INR, T, D);

	input [7:0] T,D;
	output Load, INR;

	wire temp;

	assign INR = D[6] & T[5];
	assign temp = (D[0] | D[1] | D[2] | D[6]);
	assign Load = T[4] & temp;

endmodule