module BUS_Control(x, D, T, R, I);

	input R, I;
	input [7:0] T, D;
	output [7:0] x;
	
	wire o3;
	wire D7n, Rn;
	wire a1, a2, a3, a8, a9, a10;
	
	assign D7n= ~D[7];	
	assign Rn= ~R;	
	
	assign a1= D[4] & T[4];
	assign a2= D[5] & T[5];
	assign x[1]=a1 | a2;
	assign a3= D[5] & T[4];
	assign x[2]= a3 | T[0];
	assign x[3]= T[6] & D[6];
	assign x[4]= D[3] & T[4];
	assign x[5]= T[2] & Rn;
	assign x[6]= R & T[1];
	assign a8= Rn & T[1];
	assign a9= D7n & I & T[3];
	assign o3= D[0] | D[1] | D[2];
	assign a10= o3 & T[4];
	assign x[7]= a8 | a9 | a10;	
	
endmodule
