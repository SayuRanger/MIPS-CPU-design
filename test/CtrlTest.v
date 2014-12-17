`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:43:53 03/25/2014
// Design Name:   ControlBlock
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/Ctrltest.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControlBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Ctrltest;

	// Inputs
	reg reset;
	reg [31:0] IR;
	reg clk;
	reg [31:0] regrs;
	reg [31:0] regrt;

	// Outputs
	wire IR_DR;
	wire MemWrite;
	wire [5:0] funct;
	wire [4:0] rout1;
	wire [4:0] rout2;
	wire [4:0] rin;
	wire [31:0] imm;
	wire addr_mux;
	wire Din_mux;
	wire AddrOrData_mux;
	wire MemOrReg_mux;
	wire Store_mux;
	wire imm_mux;
	wire PCcount;
	wire RegWrite;
	wire [31:0] addr_imm;
	wire [5:0] stage;

	// Instantiate the Unit Under Test (UUT)
	ControlBlock uut (
		.reset(reset), 
		.IR(IR), 
		.clk(clk), 
		.regrs(regrs), 
		.regrt(regrt), 
		.IR_DR(IR_DR), 
		.MemWrite(MemWrite), 
		.funct(funct), 
		.rout1(rout1), 
		.rout2(rout2), 
		.rin(rin), 
		.imm(imm), 
		.addr_mux(addr_mux), 
		.Din_mux(Din_mux), 
		.AddrOrData_mux(AddrOrData_mux), 
		.MemOrReg_mux(MemOrReg_mux), 
		.Store_mux(Store_mux), 
		.imm_mux(imm_mux), 
		.PCcount(PCcount), 
		.RegWrite(RegWrite), 
		.addr_imm(addr_imm), 
		.stage(stage)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		IR = 32'b00100000001000000000000000000011;
		clk = 0;
		regrs = 0;
		regrt = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#200 IR= 32'b10011100000000000000000000000000;
	end
	always #1 clk=~clk;
	
      
endmodule

