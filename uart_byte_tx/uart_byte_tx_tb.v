`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/04 16:08:50
// Design Name: 
// Module Name: uart_byte_tx_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_byte_tx_tb();

    reg CLK;
    reg Reset_n;
    reg [7:0] Data;
    wire uart_tx;
    wire LED;
    
    
uart_byte_tx uart_byte_tx_inst0(
    .CLK(CLK),
    .Reset_n(Reset_n),
    .Data(Data),
    .uart_tx(uart_tx),
    .LED(LED)
);

defparam uart_byte_tx.MCNT_DLY = 50_000_0 - 1;    //50_000个时钟周期发送一次

initial CLK = 1;
always #10 CLK = ~CLK;


initial begin
    Reset_n = 0;
    #201;
    Reset_n = 1;
    Data = 8'b0101_0101;
    #30_000_000;        //延迟30ms
    Data = 8'b1010_1010;
    #30_000_000;        //延迟30ms
    $stop; 
end
endmodule
