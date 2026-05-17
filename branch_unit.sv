`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/10 21:26:35
// Design Name: 
// Module Name: branch_unit
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


module branch_unit(

    input wire [31:0] pc,

    input wire [31:0] imm,

    input wire [31:0] rdata1,
    input wire [31:0] rdata2,

    input wire branch,
    input wire jump,

    input wire [5:0] opcode,

    input wire [31:0] inst,

    output reg branch_taken,

    output wire [31:0] branch_target,

    output wire [31:0] jump_target
);

assign branch_target =
    pc + 32'd4 + imm;

assign jump_target = {

    pc[31:28],

    inst[25:0],

    2'b00
};

always @(*) begin

    branch_taken = 0;

    if(branch) begin

        case(opcode)

        6'b000100:
            branch_taken =
                (rdata1 == rdata2);

        6'b000101:
            branch_taken =
                (rdata1 != rdata2);

        default:
            branch_taken = 0;

        endcase
    end
end

endmodule