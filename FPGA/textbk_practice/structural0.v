module first_system(out1, out2, in1, in2);

// Port definitions
input in1, in2;
output out1, out2;

// description of the idgital systems
// Structural modeling 

wire and_out, or_out;

and gate_and(and_out, in1, in2);
or gate_or(or_out, in1, in2);
xor  gate_xor(out1, and_out, or_out);
not gate_not(out2, in2);

endmodule