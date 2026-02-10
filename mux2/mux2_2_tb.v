`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/11/30 16:16:19
// Design Name: 
// Module Name: mux2_2_tb
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


module mux2_2_tb();

reg a;
reg b;
reg sel;
wire out;

mux2 mux2_a(
    .a(a),
    .b(b),
    .sel(sel),
    .out(out)
);

initial begin
    a = 1; b = 0; sel = 1;
    #20;
    a = 1; b = 0; sel = 0;
    #20;
    a = 0; b = 1; sel = 1;
    #20;
    a = 0; b = 1; sel = 0;
    #20;    
end


endmodule
