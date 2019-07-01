module SequenceCounter (load, count, data, clk, out); 
	input load, count, clk;	 
	input[2:0] data; 
	output [2:0] out;
	reg[2:0] out;
	always @ (posedge clk)
		begin  
			if(load)
				assign out=data;
			else if(count)
				assign out=out + 3'b001;
		end							
		
endmodule