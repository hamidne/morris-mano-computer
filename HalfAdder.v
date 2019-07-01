module ha(A,B,Sum,Cout);
	input[15:0] A,B;
	output[15:0] Sum;
	output Cout;

	/*wire [15:0] Sum;
	wire Cout;	*/
	
	assign Sum=A^B;
	assign Cout=A&B;
endmodule