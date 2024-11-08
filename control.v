`define IDLE 		3'b001	//1
`define ADD  		3'b010	//2
`define REMOVE 		3'b011	//3
`define UNDERFLOW 	3'b100	//4
`define OVERFLOW  	3'b101	//5

module control
(
	input clk, rst_n, 
	input underflow, overflow,
	input cmd,active,

	output reg add, remove, update, op_select,
	output reg signal_underflow, signal_overflow
);
	
	reg [2:0] c_state, n_state;
	
	always @ (posedge clk or negedge rst_n) begin
		if (!rst_n)
			c_state <= `IDLE;
		else
			c_state <= n_state;
	end

	always @ (c_state, cmd, active, underflow, overflow) begin
		add = 0; 
		remove = 0; 
		update = 0; 
		op_select = 0; 
		
		signal_underflow = 0; 
		signal_overflow = 0;

		case (c_state)
			`IDLE: 
				begin
					if (active) 
						if (cmd) 
							if (overflow) 
								n_state = `OVERFLOW; 
							else 
								n_state = `ADD;
						else
							if (underflow) 
								n_state = `UNDERFLOW; 
							else 
								n_state = `REMOVE;
					else
						n_state = `IDLE;
				end
			`ADD:
				begin
					add = 1;
					remove = 0;
					update = 1;
					op_select = 0;
					n_state = `IDLE;
				end
			`REMOVE:
				begin
					add = 0;
					remove = 1;
					update = 1;
					op_select = 1;
					n_state = `IDLE;
				end
			`OVERFLOW:
				begin
					signal_overflow = 1;
					n_state = `IDLE;
				end
			`UNDERFLOW:
				begin
					signal_underflow = 1;
					n_state = `IDLE;
				end
		endcase
	end


endmodule