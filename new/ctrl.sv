`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:27:28
// Design Name: 
// Module Name: ctrl
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


module ctrl(

    input wire [31:0] inst,

    output reg reg_dst,

    output reg reg_write,

    output reg alu_src,

    output reg mem_write,
    output reg mem_to_reg,

    output reg branch,
    output reg jump,

    output reg lui,

    output reg [3:0] alu_op
);

wire [5:0] opcode;
wire [5:0] func;

assign opcode = inst[31:26];
assign func   = inst[5:0];

always @(*) begin

    reg_dst    = 0;

    reg_write  = 0;

    alu_src    = 0;

    mem_write  = 0;
    mem_to_reg = 0;

    branch     = 0;
    jump       = 0;

    lui        = 0;

    alu_op     = 4'b0000;

    case(opcode)

    // R TYPE
    6'b000000: begin

        reg_dst   = 1;
        reg_write = 1;

        case(func)

        6'b100000: alu_op = 4'b0000; // add

        6'b100010: alu_op = 4'b0001; // sub

        6'b100100: alu_op = 4'b0010; // and

        6'b100101: alu_op = 4'b0011; // or

        6'b100110: alu_op = 4'b0100; // xor

        6'b101010: alu_op = 4'b0101; // slt

        6'b000000: alu_op = 4'b0110; // sll

        6'b000010: alu_op = 4'b0111; // srl

        endcase
    end

    // addi
    6'b001000: begin

        reg_write = 1;

        alu_src   = 1;

        alu_op    = 4'b0000;

    end

    // lw
    6'b100011: begin

        reg_write = 1;

        alu_src   = 1;

        mem_to_reg= 1;

        alu_op    = 4'b0000;

    end

    // sw
    6'b101011: begin

        mem_write = 1;

        alu_src   = 1;

        alu_op    = 4'b0000;

    end

    // beq
    6'b000100:
        branch = 1;

    // bne
    6'b000101:
        branch = 1;

    // j
    6'b000010:
        jump = 1;

    // lui
    6'b001111: begin

        reg_write = 1;

        lui = 1;

    end

    endcase
end

endmodule