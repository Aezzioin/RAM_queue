module datapath
#(
	parameter DATA_WIDTH = 6, ADDR_WIDTH = 4
)
(	
	input clk, rst_n,
	input [DATA_WIDTH - 1:0] data_in,
	input add, remove, update, op_select, we, re,
	
	output [ADDR_WIDTH - 1:0] addr_out,
	output [DATA_WIDTH - 1:0] data_out,
	output underflow, overflow
);	
	wire [ADDR_WIDTH - 1: 0] tail_out, tail_in, head_out, head_in;
	wire [ADDR_WIDTH - 1: 0] t_addr, t_addr_out;
	wire [ADDR_WIDTH - 1: 0] counter_out, counter_in;

	register #(.Width(ADDR_WIDTH)) tail
	(
		.out  (tail_out),
		.in   (tail_in ),
		.rst_n(rst_n  ),
		.load (add     ),
		.clk  (clk     )
	);
	assign tail_in = tail_out + 1;
	
	register #(.Width(ADDR_WIDTH)) head
	(
		.out  (head_out),
		.in   (head_in ),
		.rst_n(rst_n  ),
		.load (remove  ),
		.clk  (clk     )
	);
	assign head_in = head_out + 1;

	assign t_addr = op_select ? head_out : tail_out;

	register #(.Width(ADDR_WIDTH)) counter
	(
		.out  (counter_out),
		.in   (counter_in ),
		.rst_n(rst_n     ),
		.load (update     ),
		.clk  (clk        )
	);
	assign counter_in = op_select ? counter_out - 1 : counter_out + 1;

	ram #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH) ) queue 
	(	
		.data_in(data_in),
		.addr(t_addr),
		.write_en(we),
		.read_en(re),
		.clk(clk),
		.rst_n(rst_n),
		.data_out(data_out),
		.addr_out(addr_out)
	);
	
	assign underflow = counter_out == 0;
	assign overflow  = counter_out == {ADDR_WIDTH {1'b1}};
	
endmodule
