module Debounce (  // edge detect, synchronize to clock, debounce input pushbutton or switch
    input clk,
    b,  // b is the bouncy pushbutton or switch
    output reg s     // debounced version of pushbutton, synched to clock.
                     // ASSUMES the bouncing continues for less than 2 clock periods  
);
  reg [1:0] currentState;
  parameter WaitRise = 2'b00, SkipRise = 2'b01, WaitFall = 2'b10, SkipFall = 2'b11;

  initial begin
    s = 0;
    currentState = WaitRise;
  end

  always @(posedge clk) begin
    case (currentState)
      WaitRise: begin
        if (b) begin
          s <= 1;
          currentState <= SkipRise;
        end else currentState <= WaitRise;
      end
      SkipRise: currentState <= WaitFall;
      WaitFall: begin
        if (~b) begin
          s <= 0;
          currentState <= SkipFall;
        end else currentState <= WaitFall;
      end
      SkipFall: currentState <= WaitRise;
    endcase
  end
endmodule
