// Bitwidth parameterized positive edge flip flop
// with load enable

// Asynchronous negedge reset

module Register(in, out, load, clk, reset);
	parameter k = 16;

	input logic [k-1:0] in;
	input logic load;
	input logic clk;
	input logic reset;

	output logic [k-1:0] out;

	always_ff @(posedge clk, negedge reset) begin
		if (reset == 1'b0) begin
			out <= 0;
		end else begin
			out <= load ? in : out;
		end
	end

endmodule