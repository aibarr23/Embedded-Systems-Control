module vector_defn(num1,res1,res2,res3);

input [7:0] num1;
output res1;
output [3:0] res2;
output [0:7] res3;

//selecting a specific vector entry
assign res1=num1[2];

//selecting specific vector entries
assign res2=num1[7:4];

//changing the order of bits
assign res3=num1;

endmodule