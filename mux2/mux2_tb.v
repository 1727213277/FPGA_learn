`timescale 1ns / 1ps
//     时间单位 / 时间精度
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/30 09:54:00
// Design Name: 
// Module Name: mux2_tb
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


module mux2_tb();

reg S0;
reg S1;
reg S2;   
wire mux2_out;

mux2 mux2_inst0(    // 例化
    .a(S0),
    .b(S1),
    .sel(S2),
    .out(mux2_out)
); 

initial begin
    S2 = 0; S1 = 0; S0 = 0;
    #20;
    S2 = 0; S1 = 0; S0 = 1;
    #20;
    S2 = 0; S1 = 1; S0 = 0;
    #20;
    S2 = 0; S1 = 1; S0 = 1;
    #20;
    S2 = 1; S1 = 0; S0 = 0;
    #20;
    S2 = 1; S1 = 0; S0 = 1;
    #20;
    S2 = 1; S1 = 1; S0 = 0;
    #20;
    S2 = 1; S1 = 1; S0 = 1;
    #20;
end

endmodule
