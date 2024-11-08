module top_plat
(
    input clock50MHz0,
    input button0,
    input   switch0,
			switch1,
            switch2,
            switch3,
            switch4,
            switch8,
            switch9,
    output led9,led8,
    output led0,led1,
    
    output [7:0] display0,display1,display2,display3,display4,display5
);
    
    wire CLK_50M = clock50MHz0;
    wire RST_N = button0;
    assign led1 = RST_N;
	wire [5:0] data_in;
    numtodata numtodata_inst(
        .bit0(switch0),
        .bit1(switch1),
        .bit2(switch2),
        .bit3(switch3),
        .bit4(switch4),
        .data(data_in)
    );
    
    wire CLK_1s;
    clock_divider clock_divider_inst
    (
        .clk(CLK_50M),
        .clk_div(CLK_1s)
    );
    
    assign led0 = CLK_1s;

    wire [5:0] data_out;
    wire [3:0] addr_out4;
    top #(.DATA_WIDTH(6), .ADDR_WIDTH(4) ) top_inst
    (
        .clk(CLK_1s), 
        .rst_n(RST_N), 
        .active(switch9),
        .cmd(switch8),
        .data_in(data_in),
        .signal_overflow(led9),
        .signal_underflow(led8),
        .addr_out(addr_out4),
        .data_out(data_out)
    );

    wire [5:0] addr_out6;
    assign addr_out6 = {2'b00, addr_out4}; 
    ssdisplay ssdisplay_inst_addr (
        .data(addr_out6),
        .display0(display2),
        .display1(display3)
    );
    ssdisplay ssdisplay_inst_out_data (
        .data(data_out),
        .display0(display0),
        .display1(display1)
    );
    ssdisplay ssdisplay_inst_in_data (
        .data(data_in),
        .display0(display4),
        .display1(display5)
    );

endmodule