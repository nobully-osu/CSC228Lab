module Debounce ( // edge detect, synchronize to clock, debounce input pushbutton or switch
    input clk,
    b,            // b is the bouncy pushbutton or switch
    output reg s  // debounced version of pushbutton, synched to clock.
                  // ASSUMES the bouncing continues for less than 2 clock periods  
);
  reg WaitRise, SkipRise, WaitFall, SkipFall;
  reg b_sync_0, b_sync_1;

  initial begin
    b_sync_0 = 0;
    b_sync_1 = 0;
    s = 0;
    WaitRise = 1;
    SkipRise = 0;
    WaitFall = 0;
    SkipFall = 0;
  end

  always @(posedge clk) begin
    b_sync_0 <= b;
    b_sync_1 <= b_sync_0;
  end

  wire rising  = (b_sync_0 & ~b_sync_1);
  wire falling = (~b_sync_0 & b_sync_1);

  always @(posedge clk) begin
    if (WaitRise && rising) begin
      s <= 1;
      WaitRise <= 0;
      SkipRise <= 1;
      WaitFall <= 1;
      SkipFall <= 0;
    end
    else if (SkipRise && rising) begin
    end
    else if (WaitFall && falling) begin
      s <= 0;
      WaitFall <= 0;
      WaitRise <= 1;
      SkipFall <= 1; 
      SkipRise <= 0;
    end
    else if (SkipFall && falling) begin
    end 
  end
endmodule
