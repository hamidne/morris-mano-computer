module D_FlipFlop(Q, D, CLK, Enable);

	output Q;
	input D, CLK, Enable;
	reg Q, q1; 

	initial
	begin
		if(Enable)
		begin
			initial
				begin 
					Q<=1'b0;
					q1<=1'b1;
				end
				
			always @(posedge CLK)
				begin
					Q=D;
				end
		end		
	end

endmodule