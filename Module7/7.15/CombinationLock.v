module CombinationLock (
  input wire rst,
  input wire zero,
  input wire one,
  output reg unlocked,  // output 1 when pattern "01011"
  output reg [2:0] state   //outputs the numerical representation of the current state
);

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;

initial state = S0;
  always @(rst,zero,one) begin
    unlocked = 0;

    if (rst)
      state = S0;
    else begin
      case (state)
        S0: state = (zero) ? S1 : S0;
        S1: state = (one)  ? S2 : (zero ? S1 : S0);
        S2: state = (zero) ? S3 : (one ? S2 : S0);
        S3: state = (one)  ? S4 : (zero ? S1 : S0);
        S4: state = (one)  ? S5 : (zero ? S1 : S0);
        S5: begin
          unlocked = 1;
          state = (zero) ? S1 : (one ? S2 : S0);
        end
      endcase
    end
  end
endmodule