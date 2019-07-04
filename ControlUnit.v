`include "D_FF.v"
`include "Decoder3to8.v"
`include "D_FlipFlop_rst.v"
`include "Controllers/AC_Control.v" 
`include "Controllers/AR_Control.v" 
`include "Controllers/PC_Control.v" 
`include "Controllers/RAM_Control.v"
`include "Controllers/DR_Control.v"	
`include "Controllers/SC_Control.v"
`include "Controllers/BUS_Control.v"

module controlUnit(T,AC, DR,cout,  CLK, IR, CLRAC, INRAC, LoadAC, SHR, SHL ,COM, INPT,DR1, ADD, AND, CLRAR, INRAR, LoadAR, CLRPC, INRPC, LoadPC, STR, LoadRAM, INRDR, LoadDR, CLRSC, S, LoadIR, LoadTR, E, X);

    input CLK, cout;
	input [15:0] IR,AC,DR;
	input [6:0] T;
	output  CLRAC, INRAC, LoadAC, SHR, SHL ,COM, INPT,DR1, ADD, AND, CLRAR, INRAR, LoadAR, CLRPC, INRPC, LoadPC, STR, LoadRAM, INRDR, LoadDR, CLRSC, S, LoadIR, LoadTR, E;
	output [7:0] X;

	wire [7:0] D;
	wire[15:0] B;
	wire [2:0] SS;
	wire P, r, enable; 
	wire a1, a2, a3, a4, a5, a6, a7, a8, a9, a10;
	
	AC_Control ac(AND, SHR, SHL, COM, INPT, DR1, ADD, LoadAC, INRAC, CLRAC, T, D, B, I);  
	AR_Control ar(LoadAR, CLRAR, INRAR, T, D, R, I);
	PC_Control pc(CLRPC, INRPC, LoadPC, R, I, T, D, DR, AC, B, FGI, FGO, E);  
	RAM_Control ram(Str, Load, R, T, D, I);
	DR_Control dr(Load, INRDR, T, D); 
	SC_Control sc(CLRSC, T, D, R);	
	
	assign B[0]=IR[0]; assign B[1]=IR[1];assign B[2]=IR[2];assign B[3]=IR[3];assign B[4]=IR[4];assign B[5]=IR[5];assign B[6]=IR[6];
	assign B[7]=IR[7];assign B[8]=IR[8];assign B[9]=IR[9];assign B[10]=IR[10]; assign B[11]=IR[11]; 
	assign B[15]=IR[15]; 
	
	assign SS[0]=IR[12];
	assign SS[1]=IR[13];
	assign SS[2]=IR[14];
	
	Decoder3to8 dec(SS, D[7:0]);	
	BUS_Control bus(X, D, T, R, I);
	
	assign P=D[7] & T[3] &I;	
	assign In=~I;
	assign 	r=	D[7] & T[3] &In;
	
	assign LoadTR=R & T[0];
	assign LoadIR=Rn & T[1]; 
	assign Rn=~R;	
	
	assign  enable =Rn & T[2];
	D_FF dffI (I, B[15], CLK, enable);  
	
	
	
	assign a1=R & T[2] ;
	assign a2=P & B[6];
	assign o= a1 | a2;
	assign a3=P & B[7];	
	D_FlipFlopRST dffIEN(IEN, a3, CLK, a3, o);		 
//	D_FlipFlop_rst dff1 (I, a3, Clock, a3);  	 /////////////////////?????????	  

	assign no = T[2] | T[0] | T[1];
	assign non = ~no;
	assign o2 = FGI | FGO;
	assign a4 = no & o2 & IEN;
	assign a5 = T[2] & R;	
	D_FlipFlopRST dffR(R, a4, CLK, a4, a5);

	assign a6 = T[3] & D[1];
	assign a7 = B[8] & r;		   
	assign a8 = B[6] & r;
	assign a9 = B[7] & r;
	assign o3 = a6 | a7 | a8 | a9;
	assign a10 = B[10] & r; 

	initial begin
		if(a6)
			assign moshtarak = cout;
		if(a8) 
			assign moshtarak=AC[15];
		if(a9)
			assign moshtarak=AC[0];
	end

	
	//buf B1(moshtarak, cout,a6);
	//buf B2(moshtarak, AC[15], a8);
	//buf B3(moshtarak, AC[0], a9);	
	assign En=~E;
	buf(moshtarak, En , a7);  
	D_FlipFlopRST dffE(E, moshtarak, CLK, O3,a10 );
	
//	wire FGO, FGI, S, a11;
	assign a11=B[10] & P;  
	/*wire z;
	assign z= FGO;
	always @(posedge CLK )
		begin 		
	//assign z =	(a11 ? 1'b0 : FGO);	 
	D_FlipFlopRST dfffgo (FGO,, CLK,, a11);
	
	end	 */
	D_FlipFlopRST dffFGO(FGO,, CLK,, a11);  ///???
	
	assign a12=B[11] & P; 
	/*always @(posedge CLK )
		begin 		
	assign FGI=	a12 ? 1'b0 : 1'b0;
	end	*/
	D_FlipFlopRST dffFGI(FGI,, CLK,, a12);
	
	
	assign a13=B[0] & r; 
	assign a13n=~a13;
/*	always @(posedge CLK )
		begin 		
	assign S=a13 ? 1'b0 : a13n;
	end */
	D_FlipFlopRST dffS(S, a13n, CLK,, a13);
	
endmodule