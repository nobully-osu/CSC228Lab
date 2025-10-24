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

  always @(*) begin
    if (f > s) begin 
      gt = 1;
      lt = 0;
      eq = 0;
    end
    else if (f < s) begin
      gt = 0;
      lt = 1;
      eq = 0;
    end
    else begin
      gt = 0;
      lt = 0;
      eq = 1;
    end
  end
endmodule
