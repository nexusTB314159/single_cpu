`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:25:02
// Design Name: 
// Module Name: single_cycle_mips
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


module mips_cpu_top(

    input  wire clk,
    input  wire rst_n,

    output wire [31:0] pc_o,
    output wire [31:0] inst_o,

    output wire [31:0] reg_wdata_o,
    output wire [4:0]  reg_waddr_o,
    output wire        reg_we_o
);

    //====================================================
    // PC
    //====================================================

    wire [31:0] pc;
    wire [31:0] pc_next;

    //====================================================
    // Instruction
    //====================================================

    wire [31:0] inst;

    //====================================================
    // Register File
    //====================================================

    wire [4:0] rs;
    wire [4:0] rt;
    wire [4:0] rd;

    wire [4:0] shamt;

    wire [31:0] rdata1;
    wire [31:0] rdata2;

    wire [31:0] wdata;

    wire [4:0] write_addr;

    //====================================================
    // Immediate
    //====================================================

    wire [31:0] imm;

    //====================================================
    // ALU
    //====================================================

    wire [31:0] alu_a;
    wire [31:0] alu_b;

    wire [31:0] alu_result;

    wire [3:0] alu_op;

    //====================================================
    // RAM
    //====================================================

    wire [31:0] ram_rdata;

    //====================================================
    // Control
    //====================================================

    wire reg_dst;

    wire reg_write;

    wire alu_src;

    wire mem_write;
    wire mem_to_reg;

    wire branch;
    wire jump;

    wire lui;

    //====================================================
    // Branch
    //====================================================

    wire branch_taken;

    wire [31:0] branch_target;
    wire [31:0] jump_target;

    //====================================================
    // Instruction Fields
    //====================================================

    assign rs    = inst[25:21];

    assign rt    = inst[20:16];

    assign rd    = inst[15:11];

    assign shamt = inst[10:6];

    //====================================================
    // Write Register Select
    //====================================================

    assign write_addr =
        reg_dst ? rd : rt;

    //====================================================
    // PC Register
    //====================================================

    pc_reg u_pc(

        .clk(clk),
        .rst_n(rst_n),

        .en(1'b1),

        .next_pc(pc_next),

        .pc(pc)
    );

    //====================================================
    // Instruction ROM
    //====================================================

    inst_rom u_inst_rom(

        .addr(pc[11:2]),

        .inst(inst)
    );

    //====================================================
    // Controller
    //====================================================

    ctrl u_ctrl(

        .inst(inst),

        .reg_dst(reg_dst),

        .reg_write(reg_write),

        .alu_src(alu_src),

        .mem_write(mem_write),

        .mem_to_reg(mem_to_reg),

        .branch(branch),

        .jump(jump),

        .lui(lui),

        .alu_op(alu_op)
    );

    //====================================================
    // Immediate Extension
    //====================================================

    imm_ext u_imm_ext(

        .inst(inst),

        .imm(imm)
    );

    //====================================================
    // Register File
    //====================================================

    reg_file u_reg_file(

        .clk(clk),
        .rst_n(rst_n),

        .rs1(rs),
        .rs2(rt),

        .rd(write_addr),

        .wdata(wdata),

        .we(reg_write),

        .rdata1(rdata1),
        .rdata2(rdata2)
    );

    //====================================================
    // ALU Input
    //====================================================

    assign alu_a = rdata1;

    assign alu_b =
        alu_src ? imm : rdata2;

    //====================================================
    // ALU
    //====================================================

    alu u_alu(

        .a(alu_a),

        .b(alu_b),

        .shamt(shamt),

        .op(alu_op),

        .result(alu_result)
    );

    //====================================================
    // Data RAM
    //====================================================

    data_ram u_data_ram(

        .clk(clk),

        .addr(alu_result[11:2]),

        .wdata(rdata2),

        .we(mem_write),

        .rdata(ram_rdata)
    );

    //====================================================
    // Branch Unit
    //====================================================

    branch_unit u_branch(

        .pc(pc),

        .imm(imm),

        .rdata1(rdata1),
        .rdata2(rdata2),

        .branch(branch),
        .jump(jump),

        .opcode(inst[31:26]),

        .inst(inst),

        .branch_taken(branch_taken),

        .branch_target(branch_target),

        .jump_target(jump_target)
    );

    //====================================================
    // Write Back
    //====================================================

    assign wdata =

        lui ? {inst[15:0],16'b0} :

        mem_to_reg ? ram_rdata :

        alu_result;

    //====================================================
    // Next PC
    //====================================================

    assign pc_next =

        jump ? jump_target :

        (branch && branch_taken) ?

        branch_target :

        (pc + 32'd4);

    //====================================================
    // Debug
    //====================================================

    assign pc_o = pc;

    assign inst_o = inst;

    assign reg_wdata_o =
        reg_write ? wdata : 32'h0;

    assign reg_waddr_o =
        reg_write ? write_addr : 5'h0;

    assign reg_we_o = reg_write;

endmodule