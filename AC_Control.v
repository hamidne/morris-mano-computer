module AC_Control(AND, SHR, SHL, COM, INPT, DR, ADD, Load, INR, CLR, T, D, B, I);
	output AND, SHR, SHL, COM, INPT, DR, ADD, Load, INR, CLR;
	input[7:0] T, D;
	input[15:0] B;
	input I;
	
	wire a7, a9;
	wire In;
	assign In=~I;
	
	assign AND= D[0] & T[5];
	assign ADD= T[5] & D[1];
	assign DR= T[5] & D[2];
	assign SHL= B[6] & a7;
	assign SHR= B[7] & a7;
	assign COM= B[9] & a7;	   
	assign INR= B[5] & a7;
	assign a7= D[7] & In & T[3]; 
	assign CLR= a7 & B[11];                                                                                                    
	assign a9=D[7] & I & T[3]; 
	assign INPT= B[11] & a9;
	
	assign Load=( AND | ADD | DR | SHL | SHR | COM | INPT);  
	
endmodule
