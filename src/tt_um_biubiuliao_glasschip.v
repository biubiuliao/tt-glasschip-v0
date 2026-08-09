`default_nettype none

module tt_um_biubiuliao_glasschip (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,

    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,

    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);

    // 我们目前不用双向 GPIO
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // GlassChip 核心
    glasschip_core core (
        .clk    (clk),
        .rst_n  (rst_n),
        .ui_in  (ui_in),
        .uo_out (uo_out)
    );

    // 防止未使用输入警告
    wire _unused = &{ena, uio_in, 1'b0};

endmodule

`default_nettype wire