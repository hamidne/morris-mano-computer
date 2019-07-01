//`include "D_FlipFlop16.v"
module AC(Q, INR, Data, LD, CLK, CLR);

	output [15:0] Q;
	input [15:0] Data;
	input INR, LD, CLK, CLR;

	wire [15:0] inr016, Sum, moshtarak;
	reg [15:0] out;
	wire cout;

	// assign out=16'b0;
	assign inr016 = INR ? 16'b0000000000000001 : 16'b0;

	// ha h(inr016,out,Sum,cout); 
	assign {cout, Sum} = inr016 + out;
	if(INR)
		assign moshtarak = Sum;
	if(LD)
		assign moshtarak = Data;
		
	wire en;
	assign en = LD ^ INR;
	
	// D_FlipFlopRST16 d(out, moshtarak, CLK, en, CLR); 
	
	
	always @(posedge CLK or posedge CLR)
		begin
			if(CLR)
				out <= 16'b0;
			else if(en)
				out <= moshtarak;
		end	
	
	assign Q = out;
	
	
endmodule