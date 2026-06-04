module comparator (
    input  [19:0] A,
    input  [19:0] B,
    output reg    PWM
);
    always @ (A,B)
    begin
        if (A < B)
            PWM <= 1'b1;
        else
            PWM <= 1'b0;
    end
endmodule