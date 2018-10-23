// Binary to onehot decoder

module Decoder(in, out);
	parameter in_width = 3;
	parameter out_width = 8;

	logic input [in_width-1:0] in;
	logic output [out_width-1:0] out;

	// Shift 1 left
	assign out = 1 << a;
endmodule