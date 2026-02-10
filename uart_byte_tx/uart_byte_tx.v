`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/04 10:02:03
// Design Name: 
// Module Name: uart_byte_tx
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

//uart发送逻辑
//实现UART 协议的字节发送功能，基于 50MHz 时钟、9600 波特率（8N1 格式：8 位数据位、无校验位、1 位停止位），
//每秒自动发送一次输入的 8 位数据，并通过 LED 引脚翻转直观指示每次发送完成。
module uart_byte_tx(
    CLK,
    Reset_n,
    Send_Go,        //新增：发送请求。当外界需要发送时，Send_Go变高电平。
    Data,
    uart_tx,
    LED
);
    input CLK;
    input Reset_n;
    input Send_Go;
    input [7:0] Data;
    output reg uart_tx;
    output reg LED;

parameter MCNT_BAUD = 5208 - 1;         // 波特率计数最大值50_000_000/9600【单位：周期/比特（码元）】表示传输一个码元需要的时钟周期数
parameter MCNT_BIT  = 10 - 1;           // 位计数最大值
//parameter MCNT_DLY  = 50_000_000 - 1;   // 延时计数：1秒 = 50_000_000个时钟周期
    
reg [12:0] baud_div_cnt;
reg en_baud_cnt;    //波特率计数使能
reg [3:0] bit_cnt;  //位计数器
//reg [25:0] delay_cnt;           //延时计数

//波特率使能信号
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        en_baud_cnt <= 0;
    end
    else if(Send_Go) begin        //判断Send_Go
        en_baud_cnt <= 1;
    end
    else if((bit_cnt == 9)&&(baud_div_cnt == MCNT_BAUD)) begin
        en_baud_cnt <= 0;    
    end
end


// 波特率计数器    [（1/9600）  *  1000000000  /  20 ]  -  1
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        baud_div_cnt <= 0;
    end
    else if(en_baud_cnt) begin
        if(baud_div_cnt == MCNT_BAUD) begin
            baud_div_cnt <= 0;
        end
        else begin
            baud_div_cnt <= baud_div_cnt + 1'd1;        //波特率自增
        end
    end
end
 
// 位计数器
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        bit_cnt <= 0;
    end
    else if(baud_div_cnt == MCNT_BAUD) begin
        if(bit_cnt == MCNT_BIT) begin
            bit_cnt <= 0;
        end
        else begin
            bit_cnt <= bit_cnt + 1'd1;                  //位自增
        end
    end 
end

/*
// 延时计数器（锁定Data的值）
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        delay_cnt <= 0;
    end
    else if(delay_cnt == MCNT_DLY) begin
        delay_cnt <= 0;
    end
    else begin
        delay_cnt <= delay_cnt + 1'd1;
    end
end
*/

//数据锁存逻辑
reg [7:0] r_Data;
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        r_Data <= 0;
    end
    else if(Send_Go) begin      //判断Send_Go
        r_Data <= Data;
    end
    else begin
        r_Data <= r_Data;
    end
end

// 位发送逻辑
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        uart_tx <= 1'd1;                //默认状态高电平
    end
    else if(en_baud_cnt == 0) begin     //空闲状态uart_tx一直是1
        uart_tx <= 1'd1;
    end
    else begin
        case(bit_cnt)
            0: uart_tx <= 1'd0;         //起始位
            1: uart_tx <= r_Data[0];
            2: uart_tx <= r_Data[1];
            3: uart_tx <= r_Data[2];
            4: uart_tx <= r_Data[3];
            5: uart_tx <= r_Data[4];
            6: uart_tx <= r_Data[5];
            7: uart_tx <= r_Data[6];
            8: uart_tx <= r_Data[7];
            9: uart_tx <= 1'd1;         //停止位
            default: uart_tx <= uart_tx;
        endcase       
    end
end

// LED反转逻辑
always @ (posedge CLK or negedge Reset_n) begin
    if(!Reset_n) begin
        LED <= 1;
    end
    else if((bit_cnt == 9)&&(baud_div_cnt == MCNT_BAUD)) begin
        LED <= !LED;
    end
end
endmodule
