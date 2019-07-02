//`include "D_FlipFlop12.v"

//`include "HalfAdder.v"
module PC(Q, INR, Data, Load, CLK, CLR);

	output [11:0] Q;
	input [11:0] Data;
	input INR, Load, CLK, CLR;

	wire [11:0] inr012, Sum, moshtarak;
	wire cout;

	reg [15:0] out;
	assign inr012 = INR ? 12'b000000000001 : 12'b0;
	assign {cout , Sum} = inr012+ out;

	if (INR)
		assign moshtarak = Sum;
	if (Load)
		assign moshtarak = Data;

	wire en;
	assign en = Load^INR;

	always @(posedge CLK or posedge CLR)
		begin
			if(CLR)
				out <= 12'b0;
			else if(en)
				out <= moshtarak;
		end
	
	assign Q = out;
	
endmodule