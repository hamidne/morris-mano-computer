module SequenceCounter (load, count, data, clk, out);

	input load, count, clk;	 
	input [2:0] data; 
	output reg [2:0] out;

	always @ (posedge clk)
		begin  
			if(load)
				out = data;
			else if(count)
				out = out + 3'b001;
		end							
		
endmodule