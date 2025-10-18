module CombinationLock (
  input wire rst,
  input wire zero,
  input wire one,
  output reg unlocked,  // output 1 when pattern "01011"
  output reg [2:0] state   //outputs the numerical representation of the current state
);

parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100, S5 = 3'b101;
reg [2:0] state_next;

initial state = S0;
  always @(rst,zero,one) begin
    unlocked   = 0;
    state_next = state;
    
    if (rst) begin
      state_next = S0;
      unlocked   = 0;
    end else begin
      case (state)
        S0: begin 
          if (zero) state_next = S1; 
          else state_next = S0;
        end
        S1: begin 
          if (one) state_next = S2; 
          else if (zero) state_next = S1;
          else state_next = S1;
        end
        S2: begin 
          if (zero) state_next = S3; 
          else if (one) state_next = S0;
          else state_next = S2;
        end
        S3: begin 
          if (one) state_next = S4; 
          else if (zero) state_next = S1;
          else state_next = S3;
        end
        S4: begin 
          if (one) state_next = S5; 
          else if (zero) state_next = S3;
          else state_next = S4;
        end
        S5: begin
          if (zero) state_next = S1; 
          else if (one) state_next = S0;
          else state_next = S5;
        end
      endcase
    end

    state    = state_next; // update state at end of loop
    unlocked = (state == S5) ? 1 : 0; // check if state is S5 to unlock, otherwise leave locked
  end
endmodule