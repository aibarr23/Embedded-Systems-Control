module and_module(and_out,in1,in2);

input in1, in2;
output and_out;

assign and_out = in1 & in2;
endmodule

module or_module(or_out,in1,in2);

input in1,in2;
output or_out;

assign or_out = in1 | in2;
endmodule

module first_system(out1,out2,in1,in2);

input in1,in2;
output out1,out2;

wire and_out, or_out;

and_module U1(and_out,in1,in2);
or_module U2(or_out,in1,in2);

assign out1 = and_out ^ or_out;
assign nout2 = ~ in2;

endmodule