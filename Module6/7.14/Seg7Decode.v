module Seg7decode(       // convert active-high 4-bit hex to 7-segment display code, active low
   input [3:0] bin,      // binary input
   output reg [6:0] seg7 // LED cathode outputs,active low, assumes common anode LEDs. Not actually registers. 
    );
  always @(bin)
    begin
       case(bin)
       //  bit order is segments ABCDEFG
          4'b0000: seg7 = 7'b0000001; // "0"  
      //////////// insert code here for input patterns 4'b001 through 4'b1111 
          4'b0001: seg7 = 7'b1001111; // "1"
          4'b0001: seg7 = 7'b0000001; // "2"
          4'b0001: seg7 = 7'b0000001; // "3"
          4'b0001: seg7 = 7'b0000001; // "4"
          4'b0001: seg7 = 7'b0000001; // "5"
          4'b0001: seg7 = 7'b0000001; // "6"
          4'b0001: seg7 = 7'b0000001; // "7"
          4'b0001: seg7 = 7'b0000001; // "8"
          4'b0001: seg7 = 7'b0000001; // "9"
          4'b0001: seg7 = 7'b0000001; // "A"
          4'b0001: seg7 = 7'b0000001; // "b"
          4'b0001: seg7 = 7'b0000001; // "C"
          4'b0001: seg7 = 7'b0000001; // "d"
          4'b0001: seg7 = 7'b0000001; // "E"
          4'b0001: seg7 = 7'b0000001; // "F"
     
          default: seg7 = 7'b1101010; // "n" ("n" for none, but this will never happen)
       endcase
    end   
endmodule