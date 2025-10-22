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

`timescale 1 ns / 1 ns
module testbench;
   reg  clk,jolt,buzzWater,nickel,dime;
   wire [2:0] currentState;
   wire returnNickel,returnDime,dispenseJolt,dispenseBuzzWater;
   wire [6:0]seg7;
   wire [3:0]an;
 
    Top dut(clk,jolt,buzzWater,nickel,dime,currentState,returnNickel,returnDime,dispenseJolt,dispenseBuzzWater,seg7,an);
   /* 
   always begin  // display I/O every 20 ns
      #20 $display("Time=%3d reset=%b zero=%b one=%b, unlocked=%b, state=%b", $realtime, rst,zero,one,unlocked, state);
   end
*/
    initial clk=1;
    always begin  // (undivided) clk wave, period of 2
      #10  clk = ~clk;
    end
    initial begin
      #5
      `assert(currentState,3'b000,"output","initial","State","%b")
      #5
      nickel = 1;
      #5
      `assert(currentState,3'b001,"output","nickel","State","%b")
      #5 nickel = 0; dime = 1;
      #5
      `assert(currentState,3'b011,"output","dime","State","%b")
      #5 dime = 0; buzzWater = 1;
      #5
      `assert(currentState,3'b011,"output","buzzWater","State","%b")
      #5 buzzWater = 0; nickel = 1;
      #5
      `assert(currentState,3'b100,"output","nickel","State","%b")
      #5 buzzWater=1; nickel=0;
      #5
      `assert(dispenseBuzzWater,1'b1,"output","buzzWater","Dispense","%b")
      `assert(currentState,3'b000,"output","buzzWater","State","%b")
      #5 jolt = 1;
      #5
      `assert(currentState,3'b000,"output","jolt","State","%b")
      `assert(dispenseBuzzWater,1'b0,"output","buzzWater","Dispense","%b")
      #5 buzzWater=0; jolt=0; dime=1;
      #5
      `assert(currentState,3'b010,"output","dime","State","%b")
      #5 dime=0; nickel=1;
      #5
      `assert(currentState,3'b011,"output","nickel","State","%b")
      #5 nickel=0; dime=1;
      #5
      `assert(returnNickel,1'b1, "output","dime","Nickel Returned","%b")
      #5 dime=0;
      #5
      `assert(currentState,3'b100,"output","dime","State","%b")
      #5 dime=1; buzzWater = 0; jolt = 0;
      #5
      `assert(returnDime,1'b1, "output","dime","Dime Returned","%b")
      #5 dime=0;
      #5
      `assert(currentState,3'b100,"output","dime","State","%b")
      #5 jolt=1;
      #5
      `assert(dispenseJolt,1'b1,"output","jolt","Dispensed","%b")
      `assert(currentState,3'b000,"output","jolt","State","%b")
      #5 jolt=0;
      #5
      `assert(dispenseJolt,1'b0,"output","jolt","Dispensed","%b")
      $finish;
    end
endmodule