`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:28:01
// Design Name: 
// Module Name: alu
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


module alu(

    input wire [31:0] a,
    input wire [31:0] b,

    input wire [4:0] shamt,

    input wire [3:0] op,

    output reg [31:0] result
);

always @(*) begin

    case(op)

    4'b0000: result = a + b;

    4'b0001: result = a - b;

    4'b0010: result = a & b;

    4'b0011: result = a | b;

    4'b0100: result = a ^ b;

    4'b0101:
        result =
            ($signed(a) < $signed(b))
            ? 32'd1
            : 32'd0;

    4'b0110:
        result = b << shamt;

    4'b0111:
        result = b >> shamt;

    default:
        result = 32'h0;

    endcase
end

endmodule