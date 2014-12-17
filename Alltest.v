`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:37:07 03/26/2014
// Design Name:   TopModule
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/Alltest.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TopModule
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Alltest;

	// Inputs
	reg interrupt;
	reg regcount;
	reg clk;
	reg reset;
	reg start;
	reg AorM;
	reg addpush;
	reg showRorM;
	// Outputs
	wire [6:0] led;
	wire [3:0] led_select;
	wire [7:0] light;
	wire dot;

	// Instantiate the Unit Under Test (UUT)
	TopModule uut (
//		.interrupt(interrupt),
		.showRorM(showRorM),
		.regcount(regcount), 
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.AorM(AorM), 
		.addpush(addpush), 
		.led(led), 
		.led_select(led_select), 
		.light(light), 
		.dot(dot)
	);

	initial begin
		// Initialize Inputs
		showRorM =0;
		regcount = 0;
		clk = 0;
		reset = 0;
		start = 1;
		AorM = 1;
		addpush = 0;
		interrupt =0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
	end
		always #1 clk =~clk;
		always #100 regcount=~regcount;
endmodule

