`timescale 1ns / 1ps

module first_system_delay(out1,out2,in1,in2);

// port definitions
input in1,in2;
output out1,out2;

// description of the digital system
// dataflow modeling


// delay types
// and #(5)    gate_and(and_out,in1,in2);   // delay of 5ns time units
// or  #(3,4)  gate_or(or_out,in1,in2);     // rise delay is taken as three tiem units, fall delay as 4 time units
// xor #(3,4,5)    gate_xor(out1,and_out,or_out);   // rise is 3 time units, fall is 4 time units, turn off is 5 time units

assign out1 = (in1 & in2) ^ (in1 | in2);
assign #20 out2 = ~ in2;

endmodule