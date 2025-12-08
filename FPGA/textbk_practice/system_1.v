module sevenseg_driver_0 (
    clk,clr,in1,in2,in3,in4,seg,an
);
    
input clk, clr;
input [3:0] in1,in2,in3,in4;
output reg [6:0] seg;
output reg [3:0] an;
endmodule

module binarytoBCD_0 (
    binary,thos,huns,tens,ones
);
    input [11:0] binary;
    output reg [3:0] thos, huns, tens, ones;

    reg [11:0] bcd_data=0;
endmodule

module home_alarm2 (
    clk, pass, act, door,win1,win2,win3,blinkled,alarmled,seg,an,buzzer
);
    
input clk;
input [7:0] pass;
input act, door, win1, win2, win3;
output reg blinkled=0, alarmled=0;
output [6:0] seg;
output [3:0] an;
output reg buzzer=1;

localparam AOFF=2'b00, AON=2'b01, PASSCHECK=2'b10, SOUND=2'b11;
reg [1:0] state=AOFF;

integer passcounter=0;
localparam secondtime=1000000000; //1second
reg [7:0] seconds=0;
parameter password=8'h55;
reg [3:0]active=4'b0000;

wire [3:0] thos,huns,tens,ones;

binarytoBCD_0 bin({4'b0000,seconds},thos,huns,tens,ones);
sevenseg_driver_0 seg7(clk,1'b0,tens,ones,4'b0000,active,seg,an);

always @ (posedge clk)
case(state)
AOFF:
    if(act == 1) state <= AON;
AON:
    if(door != 0) state <= PASSCHECK;
    else if ((win1 | win2 | win3) != 0) state <= SOUND;
PASSCHECK:
    if (passcounter == secondtime)
    begin
      seconds <= seconds + 1'b1;
      blinkled <= ~blinkled;
      passcounter <= 0;
    end
    else
    if(pass == password) begin
      blinkled <= 0;
      seconds <= 0;
      state <= AOFF;
    end
    else if(seconds == 8'b0001_0100)
        begin
          blinkled <= 0;
          seconds <= 0;
          state <= SOUND;
        end
    else passcounter <= passcounter + 1;
SOUND:
if(pass == password)
begin
  alarmled <= 0;
  state <= AOFF;
  buzzer <= 1;
end
else begin
  alarmled <= 1;
  buzzer <= 0;
end
endcase

endmodule