`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:29:13
// Design Name: 
// Module Name: data_ram
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

module data_ram(

    input wire clk,

    input wire [9:0] addr,

    input wire [31:0] wdata,

    input wire we,

    output wire [31:0] rdata
);

reg [31:0] mem[0:1023];

integer i;

initial begin

    for(i=0;i<1024;i=i+1)

        mem[i] = 32'h00000000;

end

//==========================
// Í¬²½Ð´
//==========================

always @(posedge clk) begin

    if(we)

        mem[addr] <= wdata;

end

//==========================
// Òì²½¶Á
//==========================

assign rdata = mem[addr];

endmodule