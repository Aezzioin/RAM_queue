module numtodata (
    input bit0,
    input bit1,
    input bit2,
    input bit3,
    input bit4,
    output reg [5:0] data
);

always @(*) begin
    case (1'b1)
        bit0: data = 6'd11;  // 10 in decimal
        bit1: data = 6'd22;  // 20 in decimal
        bit2: data = 6'd33;  // 30 in decimal
        bit3: data = 6'd44;  // 40 in decimal
        bit4: data = 6'd55;  // 50 in decimal
        default: data = 6'd0; // Default case if no bit is set
    endcase
end

endmodule
