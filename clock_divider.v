module clock_divider
(
    input clk,
    output reg clk_div
); 
    //从50MHz到2Hz：放慢100M倍，即100*10^6倍,则100*10^6/2-1约=50*10^6(二进制是10 1111 1010 1111 0000 1000 0000共26位)
    //那我们用一个32位的counter来计数
    reg [31:0] counter;

    //初始化
    initial begin
        counter = 32'd0;
        clk_div = 0;
    end
    //对输出信号clk_div，根据counter进行取反操作
    always @(posedge clk) begin
        if(counter == 32'd50_000_000) begin
            counter <= 0;
            clk_div = ~clk_div;
        end
        else
            counter = counter + 32'd1;
    end
    
endmodule
