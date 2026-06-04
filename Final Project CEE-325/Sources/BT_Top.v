//module used to send ascii commands to Basys-3 FPGA via the HC-06 Bluetooth
//Android tablet or phone will be needed to pair with a HC-06 Bluetooth

module BT_PWM (
    input        clk,
    input        reset_n,
    input        clr,
    input        RX,
    output       PWM,
    output       buzz,
    output [7:0] led
);
    wire [19:0] A_net;
    wire [19:0] value_net;
    wire [8:0]  angle_net;
    wire        buzz_net;
    wire [3:0]  action;
    wire [7:0]  rx_data;
    wire        rx_ready;

    reg [7:0]  led_latch;
   

    always @(posedge clk)
        if (rx_ready) led_latch <= rx_data;

    assign led = led_latch;

   
    

  reg [16:0] tone_count  = 0;
    reg [27:0] dur_count   = 0;
    reg        buzz_reg    = 0;
    reg        buzzing     = 0;
    reg        buzz_prev   = 0; // tracks previous state of buzz_net

    always @(posedge clk)
    begin
        buzz_prev <= buzz_net; 

        // Only trigger on rising edge
        if (buzz_net && !buzz_prev && !buzzing)
        begin
            buzzing    <= 1;
            dur_count  <= 0;
            tone_count <= 0;
        end

        if (buzzing)
        begin
            if (dur_count < 28'd100_000_000)
            begin
                if (tone_count >= 17'd20_833)
                begin
                    tone_count <= 0;
                    buzz_reg   <= ~buzz_reg;
                end
                else
                    tone_count <= tone_count + 1;

                dur_count <= dur_count + 1;
            end
            else
            begin
                buzzing    <= 0;
                buzz_reg   <= 0;
                dur_count  <= 0;
                tone_count <= 0;
            end
        end
    end

    assign buzz = buzz_reg;

    async_receiver inst0(
        .clk             (clk),
        .RxD             (RX),
        .RxD_data_ready  (rx_ready),
        .RxD_data        (rx_data),
        .RxD_endofpacket (),
        .RxD_idle        ()
    );

    action_code inst1(
        .ASCII_code (led_latch),
        .action     (action),
        .buzz       (buzz_net),
        .angle      (angle_net),
        .led        ()
    );

    angle_decoder decode(
        .angle (angle_net),
        .value (value_net)
    );

    comparator compare(
        .A   (A_net),
        .B   (value_net),
        .PWM (PWM)
    );

    counter count(
        .clr   (clr),
        .clk   (clk),
        .count (A_net)
    );

endmodule


