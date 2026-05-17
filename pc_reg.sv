`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:25:47
// Design Name: 
// Module Name: pc_reg
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


module pc_reg(

    input wire clk,
    input wire rst_n,

    input wire en,

    input wire [31:0] next_pc,

    output reg [31:0] pc
);

always @(posedge clk or negedge rst_n) begin

    if(!rst_n)
        pc <= 32'h00000000;

    else if(en)
        pc <= next_pc;

end

endmodule