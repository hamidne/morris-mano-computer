module D_FF(qqq, ddd, ccc, eee);
	output reg qqq;
	input ddd, ccc, eee;
	
	if(eee)
		begin
			
	initial
		begin 
			qqq=1'b0; 
		end
		
		always @(posedge ccc)
			begin
				qqq=ddd;
			end
			
	end		
	
endmodule
