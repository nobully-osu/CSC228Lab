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

// It looks like this testbench contains a "$finish" system task.
// Be aware that some simulation programs (e.g. Modelsim) will immediately close once the "$finish" system task is executed.
// If you find that your simulation program is closing unexpectedly, try removing any "$finish" system tasks in this file.

`timescale 1 ns/ 1 ns
module testbench;
      reg  [3:0] f; 
      reg  [3:0] s;
      wire gt, lt, eq;
      comparator dut(f,s,gt,lt,eq);
   initial begin
       f = 0; s = 0;
       #5 `assert(gt, 1'b0, "output", "f = 0; s = 0;", "No signal", "%b")
       #5 `assert(lt, 1'b0, "output", "f = 0; s = 0;", "No signal", "%b")
       #5 `assert(eq, 1'b1, "output", "f = 0; s = 0;", "No signal", "%b")
       f = 3'b0011; s = 3'b0111;
       #5 `assert(gt, 1'b0, "output", "f = 3; s = 7;", "No signal", "%b")
       #5 `assert(lt, 1'b1, "output", "f = 3; s = 7;", "No signal", "%b")
       #5 `assert(eq, 1'b0, "output", "f = 3; s = 7;", "No signal", "%b")
       f = 3'b1110; s = 3'b0101;
       #5 `assert(gt, 1'b1, "output", "f = 14; s = 5;", "No signal", "%b")
       #5 `assert(lt, 1'b0, "output", "f = 14; s = 5;", "No signal", "%b")
       #5 `assert(eq, 1'b0, "output", "f = 14; s = 5;", "No signal", "%b")
       f = 3'b0101; s = 3'b0101; 
       #5 `assert(gt, 1'b0, "output", "f = 5; s = 5;", "No signal", "%b")
       #5 `assert(lt, 1'b0, "output", "f = 5; s = 5;", "No signal", "%b")
       #5 `assert(eq, 1'b1, "output", "f = 5; s = 5;", "No signal", "%b")
      $finish;
   end
endmodule
