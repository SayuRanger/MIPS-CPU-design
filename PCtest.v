`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:07:19 03/25/2014
// Design Name:   PCBlock
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/PCtest.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PCBlock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module PCtest;

	// Inputs
	reg control;
	reg push;
	reg clk;
	reg [31:0] inc;
	reg reset;
	reg addcontrol;

	// Outputs
	wire [31:0] addr;

	// Instantiate the Unit Under Test (UUT)
	PCBlock uut (
		.control(control), 
		.push(push), 
		.clk(clk), 
		.inc(inc), 
		.reset(reset), 
		.addcontrol(addcontrol), 
		.addr(addr)
	);

	initial begin
		// Initialize Inputs
		control = 0;
		push = 0;
		clk = 0;
		inc = 0;
		reset = 0;
		addcontrol = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      always #13 clk=~clk;
		always #127 push =~push;
		always #27 addcontrol =~addcontrol;
//		always #150 control =~control;
endmodule

