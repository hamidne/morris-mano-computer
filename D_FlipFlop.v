module D_FlipFlop(q, d, c, e);
	output q;
	input d, c, e;
	reg q, q1; 
	initial
		begin
	if(e)
		begin
			
	initial
		begin 
			q=1'b0; q1=1'b1;
		end
		
		always @(posedge c)
			begin
				q=d;
				
			end
			
	end		
	 end
endmodule
