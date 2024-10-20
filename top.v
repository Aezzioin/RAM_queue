module top
#(
	parameter DATA_WIDTH = 6, 
    parameter ADDR_WIDTH = 4
)
(   input clk, rst_n,
    input  [DATA_WIDTH - 1:0] data_in,
        
    output [DATA_WIDTH - 1:0] data_out
);
    
    wire add_wire, remove_wire, update_wire, op_select_wire, we_wire;
    wire underflow_wire, overflow_wire;

    datapath #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH) ) datapath_inst
	(	
		.clk(clk), 
        .rst_n(rst_n), 
        .we(we_wire), 
        .op_select(op_select_wire), 
        .remove(remove_wire), 
        .add(add_wire), 
        .update(update_wire),
		.data_in(data_in),
		.data_out(data_out),
		.underflow(underflow_wire), 
        .overflow(overflow_wire)
	);

    control control_inst
    (
	    .clk(clk), 
        .rst_n(rst_n), 
        .underflow(underflow_wire), 
        .overflow(overflow_wire),
	    .we(we_wire), 
        .op_select(op_select_wire), 
        .remove(remove_wire), 
        .add(add_wire), 
        .update(update_wire)
    );

endmodule