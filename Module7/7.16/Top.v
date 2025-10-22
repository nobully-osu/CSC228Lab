`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:50:27 03/22/2023 
// Design Name: 
// Module Name:    Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Top (
    clk,
    jolt,
    buzzWater,
    nickel,
    dime,
    currentState,
    returnNickel,
    returnDime,
    dispenseJolt,
    dispenseBuzzWater,
    seg7,
    an
);
  input clk;
  input jolt;
  input buzzWater;
  input nickel;
  input dime;
  inout [2:0] currentState;
  output returnNickel;
  output returnDime;
  output dispenseJolt;
  output dispenseBuzzWater;
  output [6:0] seg7;
  output [3:0] an;

  vending vending_ (
      clk,
      jolt,
      buzzWater,
      nickel,
      dime,
      returnNickel,
      returnDime,
      dispenseJolt,
      dispenseBuzzWater,
      currentState
  );
  Seg7decode Seg7decode_ (
      currentState,
      seg7,
      an
  );


endmodule
