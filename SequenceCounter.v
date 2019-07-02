module SequenceCounter (LD, INC, data, CLK, out);

	input LD, INC, CLK;
	input [2:0] data;
	output reg [2:0] out;

	always @ (posedge CLK)
		begin
			if(LD)
				out = data;
			else if(INC)
				out = out + 3'b001;
		end
		
endmodule