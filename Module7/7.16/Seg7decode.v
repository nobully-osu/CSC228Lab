module Seg7decode(         // convert active-high 4-digit BCD (or hex) to 7-segment display code, active low)
    input [2:0] bin,       // binary or BCD input.  Will allow A-F also
    output reg [6:0] seg7,	// LED cathode outputs,active low, assumes common anode LEDs. Not actually registers. 
    output reg [3:0] an
);
  always @(bin) begin
    an = 4'b0111;
    case (bin)
      //  bit order is segments ABCDEFG
      //  0: begin an=4'b0111; seg7 = 1; end // "0"   
      // 1: begin an=4'b0011; seg7 = 5; end// "5" 
      // 2: begin an= 4'b0011; seg7 = 10; end // "A" 
      // 3: begin an= 4'b0011; seg7 = 15; end // "E" 
      // 4: begin an= 4'b0011; seg7 = 20; end // "F" 
      3'b000:  seg7 = 7'b0000001;  // 0
      3'b001:  seg7 = 7'b1001111;  // 5
      3'b010:  seg7 = 7'b0010010;  // 10
      3'b011:  seg7 = 7'b0000110;  // 15
      3'b100:  seg7 = 7'b1001100;  //20
      default: seg7 = 7'b1101010;
    endcase
  end
endmodule
