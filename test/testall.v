`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:04:03 03/24/2014
// Design Name:   TopModule
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/testall.v
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

module testall;

	// Inputs
	reg clk;
	reg reset;
	reg start;

	// Outputs
	wire [6:0] led;
	wire [3:0] led_select;
	wire [7:0] light;

	// Instantiate the Unit Under Test (UUT)
	TopModule uut (
		.clk(clk), 
		.reset(reset), 
		.start(start), 
		.led(led), 
		.led_select(led_select), 
		.light(light)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		start = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   
	always #1 clk =~clk;
endmodule

