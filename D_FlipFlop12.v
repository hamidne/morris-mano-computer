module D_FlipFlop12(q, d, clock, enable, rst);
	output[15:0] q;
	input[15:0] d;
	input clock, enable,rst;
	reg [15:0]q; 
	always @(posedge clock or posedge rst)
		begin
			if(rst)
				begin
					q<=1'b0;
				end
				
			else if(enable)
				begin
					q<=d;
				end
			end	
	
endmodule
