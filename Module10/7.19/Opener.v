// Garage door opener FSM  
module Opener (
    input            clk,
    b,
    c,
    o,
    r,
    s,  // b: button, c: closed limit switch, o: open limit switch, r = reset, s = sensor
    output reg       d,
    u,  // d: run the motor downwards to close the door, u: run the motor upwards to open the door
    output reg [1:0] State  // an output for troubleshooting and simulation verification
);

  parameter closed = 2'b00, opening = 2'b01, open = 2'b10, closing = 2'b11;

  always @(posedge clk) begin
    if (r) begin
      // synchronous reset behavior
      if (c) begin
        State <= closed;
        u <= 0;
        d <= 0;
      end else if (o) begin
        State <= open;
        u <= 0;
        d <= 0;
      end else begin
        State <= opening;
        u <= 1;
        d <= 0;
      end
    end else begin
      case (State)
        closed: begin
          if (b) begin
            State <= opening;
            u <= 1;
            d <= 0;
          end else State <= closed;
        end
        opening: begin
          if (o) begin
            State <= open;
            u <= 0;
            d <= 0;
          end else State <= opening;
        end
        open: begin
          if (b && !s) begin
            State <= closing;
            u <= 0;
            d <= 1;
          end else begin
            State <= open;
            u <= 0;
            d <= 0;
          end
        end
        closing: begin
          if (s || b) begin
            State <= opening;
            u <= 1;
            d <= 0;
          end else if (c) begin
            State <= closed;
            u <= 0;
            d <= 0;
          end
        end
      endcase
    end
  end

endmodule
