module ram
#( 
	parameter DATA_WIDTH = 6, 
	parameter ADDR_WIDTH = 4 
)
(
	input  clk, rst_n,
	input  write_en, read_en, 

	input  [(ADDR_WIDTH-1):0] addr,
	input  [(DATA_WIDTH-1):0] data_in,
	
	output [(DATA_WIDTH-1):0] data_out,
	output [(ADDR_WIDTH-1):0] addr_out
);
	reg [DATA_WIDTH-1:0] ram_reg[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg;
	
	//保存当前地址，若需要写入则在此地址写入数据
	integer i;
	always @ (posedge clk or negedge rst_n) begin
		if (!rst_n) begin
			for (i = 0; i < 2**ADDR_WIDTH; i = i + 1)
				ram_reg[i] <= 0;
			addr_reg <= 0;
		end
		else begin
			if (write_en)
				ram_reg[addr] <= data_in;
			if (read_en)
				addr_reg <= addr;
		end
	end

	//将当前地址输出
	assign addr_out = addr_reg;
	//将当前地址对应的数据输出
	assign data_out = ram_reg[addr_reg];
    
endmodule
