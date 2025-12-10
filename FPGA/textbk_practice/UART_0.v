module UART_rx_ctrl (
    clk,rx,data,parity,ready,error
);
    input clk,rx;
    output reg [7:0] data;
    output reg parity;
    output reg ready=0;
    output reg error=0;

    parameter baud=9600;

    localparam RDY=3'b000,START=3'b001,RECIEVE=3'b010,WAIT=3'b011,CHECK=3'b100;

    reg [2:0] state = RDY;

    localparam [31:0] baud_timer = 100000000/baud;

    reg [31:0] timer = 32'b0;
    reg [3:0] bitIndex = 3'b0;
    reg [8:0] rxdata;

    always @ (posedge clk)
    case(state)
        RDY:
            if(rx == 1'b0)
                begin
                    state <= START;
                    bitIndex <= 3'b0;
                end
        START:
            if(timer == baud_timer/2)
                begin
                    state <= WAIT;
                    timer <= 14'b0;
                    error <= 1'b0;
                    ready <= 1'b0;
                end
            else timer <= timer + 1'b1;
        WAIT:
            if (timer == baud-timer)
                begin
                    timer <= 14'b0;
                    if(ready) state <= RDY;
                    else state <= RECIEVE;
                end
        RECIEVE:
            begin
                rxdata[bitIndex] <= rx;
                bitIndex <= bitIndex + 1'b1;
                if(bitIndex == 4'd8) state <= CHECK;
                else state <= WAIT;
            end
        CHECK:
        if(^rxdata[7:0] == rxdata [8])
            begin
            ready <= 1'b1;
            state <= WAIT;
            data <= rxdata[7:0];
            parity <= rxdata[8];
            end
        else
            begin
              ready <= 1'b1;
              data[7:0] <= 8'bx;
              error <= 1'b1;
              state <= RDY;
            end
    endcase
    
endmodule

module UART_tx_ctrl (
    ready,uart_tx,send,data,clk
);
    input send, clk;
    input [7:0] data;
    output ready, uart_tx;

    parameter baud = 9600;
    parameter bit_index_max = 10;

    localparam [31:0] baud_timer = 100000000/baud;

    localparam RDY = 2'b00, LOAD_BIT = 2'b01, SEND_BIT = 2'b10;

    reg [1:0] state = RDY;
    reg [31:0] timer = 0;
    reg [9:0] txData;
    reg [3:0] bitIndex;
    reg txBit = 1'b1;

    always @(posedge clk) 
    case (state)
        RDY :
            begin
              if(send)
              begin
              txData <= {1'b1, data,1'b0};
              state <= LOAD_BIT;
              end
            timer <= 14'b0;
            bitIndex <= 0;
            txBit <= 1'b1;  
            end
        LOAD_BIT:
            begin
                state <= SEND_BIT;
                bitIndex <= bitIndex + 1'b1;
                txBit <= txData[bitIndex];
            end
            SEND_BIT:
            if(timer == SEND_BIT)
            begin
                timer <= 14'b0;
                if (bitIndex == bit_index_max)
                state <= RDY;
                else state <= LOAD_BIT;
            end
            else timer <= timer + 1'b1;
        default:
            state <= RDY;
    endcase

    assign uart_tx = txBit;
    assign ready = (state == RDY);
endmodule