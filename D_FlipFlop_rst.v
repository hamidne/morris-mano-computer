module D_FlipFlopRST(q, d, clock, enable, rst);
	output q;
	input d, clock, enable,rst;
	reg q; 
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
