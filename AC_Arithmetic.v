module AC_Arthemetic_Unit(AC, AND, DR, ADD, INPR, INPT, DR0, COM, SHL, E, SHR, ACDATA, cout); 
	
	input [7:0] INPR;
	input [15:0] AC, DR;

	input AND, ADD, INPT, DR0, COM, SHL, E, SHR;

	output cout;
	output [15:0] ACDATA;

	wire [15:0] or1, or2, or3, or4, or5, or6, or7;
	wire [15:0] o4, o3, o, o1;
	
	wire [15:0] and16, add16, dr16, com16, shl16, e016, e116, shr16, a8016;
	wire [7:0] inpt8;
	
	assign and16 = (AND ? 16'b1 :16'b0);
	assign or1 = AC & and16 & DR;
	
	assign {Cout , Sum} = DR + AC;
	assign cout = Cout;
	
	assign add16 = (ADD ? 16'b1 : 16'b0);
	assign or2 = add16 & Sum;
	
	assign dr16 = (DR0 ? 16'b1 : 16'b0);
	assign or3 = dr16 & DR;
	
	assign inpt8 = (INPT ? 8'b1: 8'b0);
	assign d = inpt8 & INPR;
	
	assign or4 = {8'b00000000, d};
	
	assign com16 = (COM ? 16'b1 : 16'b0);
	assign or5 = (~AC) & com16;
	
	assign shl16 = (SHL ? 16'b1 : 16'b0);
	assign acshl = AC << 1;
	assign e016 = {15'b0, E};
	assign o = acshl | e016;
	assign e116 = {15'b1, E};
	assign o1 = e116 & o;
	assign or6 = shl16 & o1;
	
	wire[15:0] acshr, e0shift, e1shift;
	assign acshr = AC>>1;
	//shift charkheshi
	assign e0shift = E ? 16'b1000000000000000 : 16'b0;
	assign o3 = acshr | e0shift;
	assign e1shift = (E ? 16'b1111111111111111 : 16'b0111111111111111);
	assign o4 = e1shift & o3;
	
	assign shr16 = (SHR ? 16'b1111111111111111 : 16'b0);
	
	assign or7 = shr16 & o4;
	
	assign ACDATA = or1 | or2 | or3 | or4 | or5 | or6 | or7;
	
endmodule