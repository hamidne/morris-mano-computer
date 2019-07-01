`include "HalfAdder.v"	

module fulladd(sum, c_out, a, b, c_in);	
	output sum, c_out;
	input a, b, c_in;
	wire s1,c1,c2;									 
	
	ha h1(a, b, s1, c1);
	ha h2(s1, c_in, sum, c2);
	or o(c_out, c1, c2);	 
	
endmodule