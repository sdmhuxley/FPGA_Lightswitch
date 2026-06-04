module angle_decoder(
    input      [8:0] angle,
    output reg [19:0] value
);
    always @ (angle)
    begin
        value = (10'd944)*(angle) + 16'd60000;
    end
endmodule