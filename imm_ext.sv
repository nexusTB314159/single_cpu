`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:28:36
// Design Name: 
// Module Name: imm_ext
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


module imm_ext(

    input wire [31:0] inst,

    output reg [31:0] imm
);

wire [5:0] opcode;

assign opcode = inst[31:26];

always @(*) begin

    case(opcode)

    6'b001000,
    6'b100011,
    6'b101011:

        imm = {
            {16{inst[15]}},
            inst[15:0]
        };

    6'b000100,
    6'b000101:

        imm = {
            {14{inst[15]}},
            inst[15:0],
            2'b00
        };

    6'b001111:

        imm = {
            inst[15:0],
            16'b0
        };

    default:
        imm = 32'h00000000;

    endcase
end

endmodule