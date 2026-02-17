`timescale 1ns / 1ps
`include "operations0.v"

module vector_defn_tb;

reg [7:0]in1;
wire out1;
wire [3:0] out2;
wire [0:7] out3;

vector_defn UUT(.num1(in1),.res1(out1),.res2(out2),.res3(out3));

initial begin
  in1 = 8'hFA;
  #100;
end

endmodule