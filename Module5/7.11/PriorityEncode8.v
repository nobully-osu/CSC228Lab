module PriorityEncode8(in, code,z);    // 8-bit priority encoder
   input [7:0] in;          // 8-bit inputs 
   output reg [2:0] code;   // indicates the index of the most significant bit that is a 1
   output reg z;            // indicates that all input bits are 0
     // outputs are not really registered, but Verilog syntax requires reg for an "if" assignment 
     
     always @ (in, code, z) begin
      if (in == 0) begin
        code <= 3'b000;
        z = 1;
      end else
        z = 0;

      if (in[7] == 1)
        code[2:0] = 3'b111;
      else if (in[6] == 1)
        code[2:0] = 3'b110;
      else if (in[5] == 1)
        code[2:0] = 3'b101;
      else if (in[4] == 1)
        code[2:0] = 3'b100;
      else if (in[3] == 1)
        code[2:0] = 3'b011;
      else if (in[2] == 1)
        code[2:0] = 3'b010;
      else if (in[1] == 1)
        code[2:0] = 3'b001;
     end
endmodule