`timescale 1ns / 1ns

module vending (
    input            clk,
    input            jolt,               // J/Z
    input            buzzWater,          // BW/Z
    input            nickel,             // N/Z
    input            dime,               // D/Z
    output reg       returnNickel,
    output reg       returnDime,
    output reg       dispenseJolt,
    output reg       dispenseBuzzWater,
    output reg [2:0] currentState
);
  parameter S0 = 3'b000, S1 = 3'b001, S2 = 3'b010, S3 = 3'b011, S4 = 3'b100;
  // S0 = $0; S1 = .05; S2 = .10; S3 = .15; S4 = .20

  initial currentState = S0;
  always @(*) begin
    returnNickel = 0;
    returnDime = 0;
    dispenseJolt = 0;
    dispenseBuzzWater = 0;

    case (currentState)
      S0: begin
        if (nickel) currentState = S1;
        else if (dime) currentState = S2;
        else currentState = S0;
      end
      S1: begin
        if (nickel) currentState = S2;
        else if (dime) currentState = S3;
        else currentState = S1;
      end
      S2: begin
        if (nickel) currentState = S3;
        else if (dime) currentState = S4;
        else currentState = S2;
      end
      S3: begin
        if (nickel) currentState = S4;
        else if (dime) begin
          returnNickel = 1;
          currentState = S4;
        end else currentState = S3;
      end
      S4: begin
        if (nickel) begin
          returnNickel = 1;
          currentState = S4;
        end else if (dime) begin
          returnDime   = 1;
          currentState = S4;
        end else if (jolt) begin
          dispenseJolt = 1;
          currentState = S0;
        end else if (buzzWater) begin
          dispenseBuzzWater = 1;
          currentState = S0;
        end else currentState = S4;
      end
    endcase
  end
endmodule
