module ram
#( 
	parameter DATA_WIDTH = 6, 
	parameter ADDR_WIDTH = 4 
)
(
	input  [(DATA_WIDTH-1):0] data_in,
	input  [(ADDR_WIDTH-1):0] addr,
	input  write_en, clk,
	
	output [(DATA_WIDTH-1):0] data_out,
	output [(ADDR_WIDTH-1):0] addr_out
);
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];
	reg [ADDR_WIDTH-1:0] addr_reg;

	//保存当前地址，若需要写入则在此地址写入数据
	always @ (posedge clk)
	begin
		addr_reg <= addr;
		if (write_en)
			ram[addr] <= data_in;
	end
	//将当前地址对应的数据输出
	assign data_out = ram[addr_reg];
    //将当前地址输出
	assign addr_out = addr_reg;

endmodule
