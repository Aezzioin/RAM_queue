module ssdisplay(
    input [5:0] data,       // 6-bit input data
    output reg [7:0] display0, // 8-bit output for the first 7-segment display
    output reg [7:0] display1  // 8-bit output for the second 7-segment display
);

    // Seven-segment display encoding for digits 0-9
    function [7:0] seven_seg;
        input [3:0] digit;
        case (digit)
            4'd0: seven_seg = 8'b11000000; // Display 0
            4'd1: seven_seg = 8'b11111001; // Display 1
            4'd2: seven_seg = 8'b10100100; // Display 2
            4'd3: seven_seg = 8'b10110000; // Display 3
            4'd4: seven_seg = 8'b10011001; // Display 4
            4'd5: seven_seg = 8'b10010010; // Display 5
            4'd6: seven_seg = 8'b10000010; // Display 6
            4'd7: seven_seg = 8'b11111000; // Display 7
            4'd8: seven_seg = 8'b10000000; // Display 8
            4'd9: seven_seg = 8'b10010000; // Display 9
            default: seven_seg = 8'b11111111; // Display nothing
        endcase
    endfunction

    reg [3:0] tens; // 十位数
    reg [3:0] ones; // 个位数

    always @(*) begin
        // 将6位数据转换为十进制表示的十位和个位
        tens = data / 10;
        ones = data % 10;

        // 将十位和个位转换为七段数码管显示的编码
        display1 = seven_seg(tens);
        display0 = seven_seg(ones);
    end

endmodule
