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

// Testbench for Debounce module, rising bounces lasting less than 2 clocks
`timescale 1 ns/ 1 ns
module testbench();
                                        
reg clk, b;  // inputs   
wire s;      // output  

Debounce uut (clk,b,s);

initial clk = 0; 
   always begin  // Clk wave, period of 60
      #30  clk = ~clk;
   end

initial
   begin
      b = 0;
  #25 b = 1;  // first rise
  // s should remain 0 here until next rising clock edge
  // assert s = 0
    `assert(s, 1'b0, "s","b=1, clk=0, is s = 0 before first clock?","s = 0 before first clock", "%b")
  
  #10 b = 0;  //bounces low
  
 // s should be 1 here, after rising clock edge
 // assert s = 1
   `assert(s, 1'b1, "s","b=0, clk=1, is s = 1 after first bounce low?","s = 1 after first bounce low", "%b")
  #10 b = 1;
  #20 b = 0;  //bounces low
  
  #10 b = 1;
  #10 b = 0;  //bounces low
  #10 b = 1;
  #10 b = 0;  //bounces low
 // assert s = 1
    `assert(s, 1'b1, "s","b=0, clk=1, is s = 1 after 4 bounces low?","s = 1 after 4 bounces low", "%b")
  #20 b = 1;  //stays high
  
  #60      // assert s = 1
    `assert(s, 1'b1, "s","b=1, clk=1, is s = 1 after b remains high?","s = 1 after b remains high", "%b")
  #10 $finish;
   end 
endmodule