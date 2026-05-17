`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:31:54
// Design Name: 
// Module Name: reg_file
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


module reg_file(

    input wire clk,
    input wire rst_n,

    input wire [4:0] rs1,
    input wire [4:0] rs2,
    input wire [4:0] rd,

    input wire [31:0] wdata,

    input wire we,

    output wire [31:0] rdata1,
    output wire [31:0] rdata2
);

reg [31:0] regs[0:31];

integer i;

always @(posedge clk or negedge rst_n) begin

    if(!rst_n) begin

        for(i=0;i<32;i=i+1)
            regs[i] <= 32'h0;

    end

    else if(we && (rd != 0))
        regs[rd] <= wdata;

end

assign rdata1 =
    (rs1 == 0) ? 32'h0 : regs[rs1];

assign rdata2 =
    (rs2 == 0) ? 32'h0 : regs[rs2];

endmodule