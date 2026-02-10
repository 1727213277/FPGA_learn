`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/03 15:14:34
// Design Name: 
// Module Name: decoder_3_8_tb
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


module decoder_3_8_tb();

    reg A0;
    reg A1;
    reg A2;
    wire Y0;
    wire Y1;
    wire Y2;
    wire Y3;
    wire Y4;
    wire Y5;
    wire Y6;
    wire Y7;
    
decoder_3_8 decoder_3_8_inst0(
    .A0(A0),
    .A1(A1),
    .A2(A2),
    .Y0(Y0),
    .Y1(Y1),
    .Y2(Y2),
    .Y3(Y3),
    .Y4(Y4),
    .Y5(Y5),
    .Y6(Y6),
    .Y7(Y7)
);

initial begin
    A2 = 0;A1 = 0;A0 = 0;
    #20;
    A2 = 0;A1 = 0;A0 = 1;
    #20;
    A2 = 0;A1 = 1;A0 = 0;
    #20;
    A2 = 0;A1 = 1;A0 = 1;
    #20;
    A2 = 1;A1 = 0;A0 = 0;
    #20;
    A2 = 1;A1 = 0;A0 = 1;
    #20;
    A2 = 1;A1 = 1;A0 = 0;
    #20;
    A2 = 1;A1 = 1;A0 = 1;
    #20;
    $stop;
end

endmodule
