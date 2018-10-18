// 16 bit 4-operation ALU
// fully combinational
// no multicycle operatons

module ALU(
	input logic [15:0] a_in, b_in,
	input logic [1:0] op,
	
	output logic [15:0] out,
	output [2:0] status
);

	// Status bits
	logic overflow;
	logic equalzero;
	logic negative;

	// Combinational logic
	// Op code mapping:
	// 00 - ADD
	// 01 - SUBTRACT / COMPARE (since comparison is subtraction and then check if 0)
	// 10 - AND
	// 11 - NEGATE a_in
	always_comb begin
		case (op)
			2'b00: out = a_in + b_in;
			2'b01: out = a_in - b_in;
			2'b10: out = a_in & b_in;
			2'b11: out = ~a_in;
		endcase
	end

	// Assign status bits
	assign overflow = (a_in[15] ^ out[15]) & (b_in[15] ^ out[15]);
	assign equalzero = !out;
	assign negative = out[15];
	assign status = {overflow, negative, equalzero};

endmodule