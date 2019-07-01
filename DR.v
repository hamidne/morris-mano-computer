//`include "D_FlipFlop16.v"

					 

module DR(Q, INR, Data, Load, CLK, CLR);
	output [15:0] Q;
	input[15:0] Data;
	input INR, Load, CLK, CLR; 	 
	wire [15:0] inr016,Sum,moshtarak;
	wire cout;	
	reg[15:0] out;
	assign inr016=INR?16'b0000000000000001:16'b0;
	//ha ha1(inr016,out,Sum,Cout); 
	assign {cout , Sum}=inr016 + out;
	if(INR)					 	   
		assign moshtarak=Sum;
	if(Load)
		assign moshtarak=Data;
		
	wire en;
	assign en=Load^INR;
	//payda kardan ddff va edame  
	
	// D_FlipFlopRST16 dff16(out, moshtarak, CLK, en, CLR); 

	
	
	always @(posedge CLK or posedge CLR)
		begin
			if(CLR)
				begin
					out<=16'b0;
				end
				
			else if(en)
				begin
					out<=moshtarak;
				end										  
			end	
	
	assign Q=out;
	
	
	
endmodule
