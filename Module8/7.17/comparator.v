module comparator (
    f,
    s,
    gt,
    lt,
    eq
);  // 4-bit comparator
  input [3:0] f;  // 4-bit inputs
  input [3:0] s;
  output reg gt;
  output reg lt;
  output reg eq;

  reg gtFlag = 0;
  reg ltFlag = 0;
  reg eqFlag = 0;

  // insert code here

endmodule
