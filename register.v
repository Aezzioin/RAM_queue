module register
#(
	parameter	Width = 4
)
(	
	input					rst_n, load, clk,
	input 	   [Width-1:0] 	in,

	output reg [Width-1:0] 	out
);
	//控制register的归零rst_n和更新load
	always @(posedge clk or negedge rst_n) begin
		if (!rst_n)
			out <= 0;
		else if (load)
			out <= in;
	end
endmodule
