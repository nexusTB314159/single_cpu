`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/05/08 22:30:05
// Design Name: 
// Module Name: tb_mips
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



//==========================================================
// File: tb_mips_cpu.v
//==========================================================

`timescale 1ns/1ps

module tb_mips;

reg clk;
reg rst_n;

wire [31:0] pc_o;
wire [31:0] inst_o;

wire [31:0] reg_wdata_o;
wire [4:0]  reg_waddr_o;
wire reg_we_o;

mips_cpu_top uut(

    .clk(clk),
    .rst_n(rst_n),

    .pc_o(pc_o),
    .inst_o(inst_o),

    .reg_wdata_o(reg_wdata_o),
    .reg_waddr_o(reg_waddr_o),
    .reg_we_o(reg_we_o)
);

initial begin

    clk = 0;

    forever #5 clk = ~clk;

end

initial begin

    rst_n = 0;

    #20;

    rst_n = 1;

end

initial begin

    #500;

    $stop;

end

initial begin

    $monitor(

        "time=%0t pc=%h inst=%h we=%b waddr=%d wdata=%h",

        $time,

        pc_o,
        inst_o,

        reg_we_o,
        reg_waddr_o,
        reg_wdata_o
    );

end

endmodule