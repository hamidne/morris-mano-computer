module D_FlipFlopRST(q, d, clock, enable, rst);

	output q;
	input d, clock, enable,rst;

	reg q;

	always @(posedge clock or posedge rst)
		begin
			if(rst)
				q<=1'b0;
			else if(enable)
				q<=d;
		end	
	
endmodule
