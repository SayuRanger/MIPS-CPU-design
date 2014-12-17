`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:34:05 03/27/2014
// Design Name:   ALU
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign -version2/MIPS/alu_overflow_test.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ALU
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module alu_overflow_test;

	// Inputs
	reg [5:0] funct;
	reg [31:0] INa;
	reg [31:0] INb;
	reg clk;

	// Outputs
	wire [31:0] OUT;
	wire overflow;

	// Instantiate the Unit Under Test (UUT)
	ALU uut (
		.funct(funct), 
		.INa(INa), 
		.INb(INb), 
		.clk(clk), 
		.OUT(OUT), 
		.overflow(overflow)
	);

	initial begin
		// Initialize Inputs
		funct = 6'b100000;
		INa = 32'b11111111111111111111111111111111;
		INb = 32'b11111111111111111111111111111111;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      always #1 clk =~clk;
endmodule

