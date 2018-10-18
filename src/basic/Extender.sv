// Sign extender to convert narrow bitwidth busses to wide bitwidth

module Extender(in, out);
	parameter in_width = 8;
	parameter out_width = 16;

	input logic [in_width:0] in;
	output logic [out_width:0] out;

	// Using {n{bit}} syntax to repeat
	assign out = {
		{(out_width - in_width){in[in_width-1]}},
		in
	};
endmodule