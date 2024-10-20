`define IDLE 		3'b001	//1
`define ADD  		3'b010	//2
`define REMOVE 		3'b011	//3
`define UNDERFLOW 	3'b100	//4
`define OVERFLOW  	3'b101	//5

module control
(
	input clk, rst_n, 
	input underflow, overflow,
	
	output reg we, op_select, remove, add, update
);
	
	reg [2:0] c_state, n_state;
	
	//用"上个上升沿时获得的下一状态"对当前状态赋值，(或异步重置当前状态为空闲)
	always @ (posedge clk or negedge rst_n) begin
		if (!rst_n)
			c_state <= `IDLE;
		else
			c_state <= n_state;
	end

	//获取"当前上升沿时获得的下一状态"
	always @ (c_state, underflow, overflow) begin
		case (c_state)
			`IDLE: begin
				if (underflow)
					n_state <= `ADD;
				else if (overflow)
					n_state <= `REMOVE;
			end
			`ADD: begin
				if (overflow)
					n_state <= `OVERFLOW;
			end
			`OVERFLOW: begin
				if (overflow)
					n_state <= `IDLE;
			end
			`REMOVE: begin
				if (underflow)
					n_state <= `UNDERFLOW;
			end
			`UNDERFLOW: begin
				if (underflow)
					n_state <= `IDLE;
			end
		endcase
	end

	//根据下一状态，给出“希望下一时刻系统读取的信号”
	always @ (n_state) begin
		case (n_state)
			`IDLE: begin
				add 		<= 0;
				remove 		<= 0;
				update 		<= 0;
				op_select 	<= 0; //-
				we 			<= 0;
			end
			`ADD: begin
				add 		<= 1;
				remove 		<= 0;
				update 		<= 1;
				op_select 	<= 0;
				we 			<= 1;
			end
			`OVERFLOW: begin
				add 		<= 1;
				remove 		<= 0;
				update 		<= 0;
				op_select 	<= 0;
				we 			<= 1;
			end
			`REMOVE: begin
				add 		<= 0;
				remove 		<= 1;
				update 		<= 1;
				op_select 	<= 1;
				we 			<= 0;
			end
			`UNDERFLOW: begin
				add 		<= 0;
				remove 		<= 1;
				update 		<= 0;
				op_select 	<= 1;
				we 			<= 0;
			end
			endcase
	end

endmodule