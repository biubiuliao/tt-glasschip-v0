module glasschip_core (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out
);

    reg [2:0] sync1;
    reg [2:0] sync2;
    reg [2:0] prev;

    wire [2:0] event_pulse;
    wire event_detected;

    reg wake;
    reg [3:0] wake_timer;
    reg [3:0] event_counter;

    // 外部事件同步
    always @(posedge clk) begin
        if (!rst_n) begin
            sync1 <= 3'b000;
            sync2 <= 3'b000;
            prev  <= 3'b000;
        end else begin
            sync1 <= ui_in[2:0];
            sync2 <= sync1;
            prev  <= sync2;
        end
    end

    // 上升沿检测
    assign event_pulse = sync2 & ~prev;
    assign event_detected = |event_pulse;

    // Wake 控制
    always @(posedge clk) begin
        if (!rst_n) begin
            wake       <= 1'b0;
            wake_timer <= 4'd0;
        end else begin

            if (event_detected) begin
                wake       <= 1'b1;
                wake_timer <= 4'd0;
            end

            else if (wake) begin
                if (wake_timer == 4'd15) begin
                    wake       <= 1'b0;
                    wake_timer <= 4'd0;
                end else begin
                    wake_timer <= wake_timer + 1'b1;
                end
            end

        end
    end

    // 事件计数
    always @(posedge clk) begin
        if (!rst_n)
            event_counter <= 4'd0;
        else if (event_detected)
            event_counter <= event_counter + 1'b1;
    end

    assign uo_out[0]   = wake;
    assign uo_out[1]   = event_detected;
    assign uo_out[3:2] = 2'b00;
    assign uo_out[7:4] = event_counter;

endmodule