// Register file is a collection of registers
// Handles incoming write and address signals

// Total of 8 registers, 3 bit address required

module RegisterFile(
	input logic [15:0] data_in,
	input logic [2:0] write_addr, read_addr,
	input logic write_en,
	input logic clk,
	input logic reset,

	output logic [15:0] data_out
);

	// Registers one hot select bus that selects a register to be interacted with
	logic [7:0] write_select;

	// Which bit in the load bus determines from the addrses
	// Need bin->one hot decoder
	Decoder #(3, 8) WRITE_ADDR_DECODER(.in(write_addr), .out(select));

	// Register load bus
	// A particular register can only be written to if the address is right (select enabled)
	// and write enabled is high
	logic [7:0] load;
	assign load = write_select & {8{write_en}};

	// Register output busses
	logic [15:0] r0_out, r1_out, r2_out, r3_out, r4_out, r5_out, r6_out, r7_out;

	// Main register modules (in, out, load, clk, reset)
	Register R0(
		.in(data_in),
		.out(r0_out),
		.load(load[0]),
		.*
	);
	Register R1(
		.in(data_in),
		.out(r1_out),
		.load(load[1]),
		.*
	);
	Register R2(
		.in(data_in),
		.out(r2_out),
		.load(load[2]),
		.*
	);
	Register R3(
		.in(data_in),
		.out(r3_out),
		.load(load[3]),
		.*
	);
	Register R4(
		.in(data_in),
		.out(r4_out),
		.load(load[4]),
		.*
	);
	Register R5(
		.in(data_in),
		.out(r5_out),
		.load(load[5]),
		.*
	);
	Register R6(
		.in(data_in),
		.out(r6_out),
		.load(load[6]),
		.*
	);
	Register R7(
		.in(data_in),
		.out(r7_out),
		.load(load[7]),
		.*
	);

	// To find the right register to output
	// we also need bin->one hot decoder to decode read address to one hot bus for mux
	logic [7:0] read_select;
	Decoder #(3, 8) READ_ADDR_MUX(.in(read_addr), .out(read_select));

	// For output, we feed all register output into mux8
	Mux8OH READ_DATA_MUX(
		.a0(r0_out),
		.a1(r1_out),
		.a2(r2_out),
		.a3(r3_out),
		.a4(r4_out),
		.a5(r5_out),
		.a6(r6_out),
		.a7(r7_out),
		.select(read_select),
		.out(data_out)
	);

endmodule