module CombinationLock (
    input wire rst,
    input wire zero,
    input wire one,
    output reg unlocked,    // output 1 when pattern "01011"
    output reg [2:0] state  // outputs the numerical representation of the current state
);

  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
  reg [2:0] state_next;

  initial begin
    state = S0;
    unlocked = 0;
  end
  always @(rst, zero, one) begin
    state_next = state;

    if (rst) begin
      state_next = S0;
      unlocked   = 0;
    end else begin
      case (state)
        S0: state_next = (zero) ? S1 : S0;
        S1: state_next = (one)  ? S2 : (zero ? S1 : S0);
        S2: state_next = (zero) ? S3 : (one  ? S0 : S2);
        S3: state_next = (one)  ? S4 : (zero ? S1 : S3);
        S4: state_next = (one)  ? S5 : (zero ? S3 : S4);
        S5: begin
          unlocked   = 1;
          state_next = (zero) ? S1 : (one ? S0 : S5);
        end
      endcase
    end

    state = state_next;  // update state at end of loop
  end
endmodule
