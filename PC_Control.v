module PC_Control(CLR, INR, Load, R, I, T, D, DR, AC, B, FGI, FGO, E);
	output CLR, INR, Load ;
	input R, I, FGI, FGO, E;
	input [7:0] T, D;
	input[15:0] B;
	input[15:0] DR, AC;	 
	assign Rn= ~R; 
	assign In= ~I;
	assign AC15n=~AC[15];
	assign En=~E;
	assign a1= Rn & T[1];
	assign CLR= R & T[1];
	assign a3= R & T[2];
	assign p= I & T[3] & D[7]; 
	assign r= In & D[7] & T[3];	
	wire eqdr, egac;					  						
	assign DrCompare=( ~DR ? 1'b1:1'b0);
   	assign AcCompare= (~AC ? 1'b1:1'b0);
	assign a6=  DrCompare & D[6] & T[6];
	assign a7= 	AcCompare & B[2];
	assign a8= B[3] & AC[15];
	assign a9= AC15n & B[4];
	assign a10= En & B[1];
	assign o1= a7 | a8 | a9 | a10;
	assign a11= r & o1;
	assign a12= B[9] & FGI;
	assign a13= B[8] & FGO;
	assign o2= 	a12 | a13;
	assign a14= p & o2;
	assign a15= T[4] & D[4];
	assign a16= D[5] & T[5]; 
	assign Load= a15 | a16;
	assign INR= a1 | a3 | a6 | a11 | a14;
	
endmodule

	
	