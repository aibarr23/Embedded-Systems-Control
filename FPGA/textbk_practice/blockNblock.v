module blocking_nonblocking(y,x,clk);

input x,clk;
output reg [5:0] y;

initial y=6 'b000000;

always @ (posedge clk)
begin
  y[0] = x;
  y[1] = y[0];
  y[2] = y[1];

  y[3] = y[2];
  y[4] = y[3];
  y[5] = y[4];
end
endmodule