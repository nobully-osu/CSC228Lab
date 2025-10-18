`define assert(actual, expected, outputName, inputs, description, type) \
    $write("\nTIME: "); $write($realtime); \
    if (actual == expected) \
        $display("   PASSED:   "); \
    else begin \
        $display(" ** FAILED:   "); \
        if (description) $display("TEST: %s", description); \
    end \
    $write("%s = ", outputName, type, actual); \
    $write(", EXPECTED: ", type, expected); \
    if (inputs) $display(" WITH: %s", inputs);
// End of `assert macro.

`define info(message) \
    $write("\nTIME "); $display($realtime); \
    $display("INFO %s", message);
// End of `info macro.

`define infof(messageFormat) \
    $write("\nTIME "); $display($realtime); \
    $write("INFO "); \
    $display messageFormat;
// End of `infof macro.

// It looks like this testbench contains a "$finish" system task.
// Be aware that some simulation programs (e.g. Modelsim) will immediately close once the "$finish" system task is executed.
// If you find that your simulation program is closing unexpectedly, try removing any "$finish" system tasks in this file.

/*`define assert(actual, expected, outputName, inputs, description, type) \
    $write("\nTIME: "); $write($realtime); \
    if (actual == expected) \
        $display("   PASSED:   "); \
    else begin \
        $display(" ** FAILED:   "); \
        if (description) $display("TEST: %s", description); \
    end \
    $write("%s = ", outputName, type, actual); \
    $write(", EXPECTED: ", type, expected); \
    if (inputs) $display(" WITH: %s", inputs);
// End of `assert macro.

`define info(message) \
    $write("\nTIME "); $display($realtime); \
    $display("INFO %s", message);
// End of `info macro.

`define infof(messageFormat) \
    $write("\nTIME "); $display($realtime); \
    $write("INFO "); \
    $display messageFormat;
// End of `infof macro.
*/
// It looks like this testbench contains a "$finish" system task.
// Be aware that some simulation programs (e.g. Modelsim) will immediately close once the "$finish" system task is executed.
// If you find that your simulation program is closing unexpectedly, try removing any "$finish" system tasks in this file.

`timescale 1 ns / 1 ns
module testbench;
   reg  rst, zero, one;
   wire unlocked;
   wire [2:0] state;
 
    CombinationLock dut(rst, zero, one, unlocked,state);
   /* 
   always begin  // display I/O every 20 ns
      #20 $display("Time=%3d reset=%b zero=%b one=%b, unlocked=%b, state=%b", $realtime, rst,zero,one,unlocked, state);
   end
*/

    initial begin
      rst =0;
      zero = 0;
      one = 0;
      #5  rst = 1;
      #5
      `assert(state,3'b000,"output","rst=1","Out","%b")
      #5  rst = 0;
      #5
      `assert(state,3'b000, "output","rst=0","Out","%b")
      #5 zero=1;
      #5
      `assert(state,3'b001, "output","zero button","Out","%b")
      #5  rst = 1;
      #5  zero = 0;
      #5
      `assert(state,3'b000,"output","rst=1","Out","%b")
      #5 rst=0; 
      #5 zero=1;
      #5
      `assert(state,3'b001,"output","zero button","Out","%b")
      #5  one=1; zero = 0;
      #5
      `assert(state,3'b010,"output","one button","Out","%b")
      #5  one= 0;
      #5  one = 1;
      #5
      `assert(state,3'b000,"output","one button","Out","%b")
       #5 zero=1; one = 0;
       #5
      `assert(state,3'b001,"output","zero button","Out","%b")
      #5  zero = 0; one=1;
      #5
      `assert(state,3'b010,"output","one button","Out","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b011,"output","zero button","Out","%b")
      #5  zero = 0; 
      #5  zero= 1;
      #5
      `assert(state,3'b001,"output","zero button","Out","%b")
      #5  zero = 0; one=1;
      #5
      `assert(state,3'b010,"output","one button","Out","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b011,"output","zero button","Out","%b")
      #5 zero=0; one = 1;
      #5
      `assert(state,3'b100,"output","one button","Out","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b011,"output","zero button","Out","%b")
      #5 zero=0; one = 1;
      #5
      `assert(state,3'b100,"output","one button","Out","%b")
      #5 one = 0;
      #5 one = 1;
      #5
      `assert(state,3'b101,"output","one button","Out","%b")
      `assert(unlocked,1'b1,"output","one button","Unlocked","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b001,"output","zero button","Out","%b")
      `assert(unlocked,1'b0,"output","zero button","Unlocked","%b")
      #5 zero = 0; one=1;
      #5
      `assert(state,3'b010,"output","one button","Out","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b011,"output","zero button","Out","%b")
      #5 zero=0; one = 1;
      #5
      `assert(state,3'b100,"output","one button","Out","%b")
      #5 zero=1; one = 0;
      #5
      `assert(state,3'b011,"output","zero button","Out","%b")
      #5 zero=0; one = 1;
      #5
      `assert(state,3'b100,"output","one button","Out","%b")
      #5 one = 0;
      #5 one = 1;
      #5
      `assert(state,3'b101,"output","one button","Out","%b")
      `assert(unlocked,1'b1,"output","one button","Unlocked","%b")
      #5 one = 0;
      #5 one = 1;
      #5
      `assert(state,3'b000,"output","one button","Out","%b")
      `assert(unlocked,1'b0,"output","one button","Unlocked","%b")
      $finish;
    end
endmodule