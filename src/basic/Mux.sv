// Parameterized multiplexer
// input bus is all inputs tied into a single bus for ease of 
// parameterization


module Mux_(in_bus, sel, out);

	parameter bitwidth = 16;
	parameter num_input = 8;
	parameter sel_width = 3;

	input logic [(bitwidth * num_input)-1:0] in_bus;
	input logic [sel_width-1:0] sel;
	output logic [bitwidth-1:0] out;

	// ??? synthesizable ???
	generate;
		for (genvar i = 0; i < num_input; i++) begin: MuxInternal
			assign out = (i == sel) ? in_bus[(bitwidth * (i + 1) - 1):(bitwidth * i)] : 'z;
		end
	endgenerate

endmodule

// Non parameterized for our specific application
module Mux3(a0, a1, a2, select, out);
	parameter k = 1;

	input logic [k-1:0] a0, a1, a2;
	input logic [1:0] select;
	output logic [k-1:0] out;

	assign out = (select == 2'b00) ? a0 : (select == 2'b01) ? a1 : a2;
endmodule

module Mux4(
	a0, a1, a2, a3,
	select, out
);
	parameter k = 1;

	input logic [k-1:0] a0, a1, a2, a3;
	input logic [1:0] select;
	output logic [k-1:0] out;

	assign out = (select == 2'b00) ? a0 :
				(select == 2'b01) ? a1 :
				(select == 2'b10) ? a2 : a3;
endmodule

// One hot muxes
module Mux8OH(
	a0, a1, a2, a3, a4, a5, a6, a7,
	select, out
);
	parameter k = 1;

	input [k - 1:0] a0, a1, a2, a3, a4, a5, a6, a7;
	input [7:0] select;
	output [k - 1:0] out;

	assign out =
	({k{select[0]}} & a0) |
	({k{select[1]}} & a1) |
	({k{select[2]}} & a2) |
	({k{select[3]}} & a3) |
	({k{select[4]}} & a4) |
	({k{select[5]}} & a5) |
	({k{select[6]}} & a6) |
	({k{select[7]}} & a7);
endmodule