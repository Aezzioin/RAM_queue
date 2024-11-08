module top
#(
	parameter DATA_WIDTH = 6, 
    parameter ADDR_WIDTH = 4
)
(   input clk, rst_n,
    input active,cmd,
    input  [DATA_WIDTH - 1:0] data_in,
    
    output signal_underflow,signal_overflow,
    output [ADDR_WIDTH - 1:0] addr_out,
    output [DATA_WIDTH - 1:0] data_out
);
    
    wire add_wire, remove_wire, update_wire, op_select_wire;
    wire underflow_wire, overflow_wire;

    datapath #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH) ) datapath_inst
	(	
		.clk(clk), 
        .rst_n(rst_n), 
        .we(add_wire), 
        .re(remove_wire),
        .op_select(op_select_wire), 
        .remove(remove_wire), 
        .add(add_wire), 
        .update(update_wire),
		.data_in(data_in),
        .addr_out(addr_out),
		.data_out(data_out),
		.underflow(underflow_wire), 
        .overflow(overflow_wire)
	);

    control control_inst
    (
	    .clk(clk), 
        .rst_n(rst_n), 
        .active(active),
        .cmd(cmd),
        .underflow(underflow_wire), 
        .overflow(overflow_wire),
        .op_select(op_select_wire), 
        .remove(remove_wire), 
        .add(add_wire), 
        .update(update_wire),
        .signal_underflow(signal_underflow),
        .signal_overflow(signal_overflow)
    );

endmodule