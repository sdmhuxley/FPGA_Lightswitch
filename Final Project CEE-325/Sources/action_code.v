module action_code(ASCII_code, action, buzz, angle, led);
    input  [7:0] ASCII_code;
    output [3:0] action;
    reg    [3:0] action;
    output reg [8:0] angle;
    output reg       buzz;
    output reg [7:0] led;

    always @ (ASCII_code)
    begin
        // Default assignments prevent latches
        angle  = 9'd0;
        buzz   = 1'b0;
        led    = 8'b0;
        action = 4'b0;
    
        case(ASCII_code)
            8'b0000001: angle = 9'd00; // '1' -> 0 degrees
            8'b0000010: angle = 9'd90; // '2' -> 90 degrees
            default:     angle = 9'd45;
        endcase

        if(angle == 9'd90)
        begin
            buzz   = 1'b1;
        end
        
    end
endmodule