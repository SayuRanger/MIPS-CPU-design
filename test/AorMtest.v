`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:00:16 03/25/2014
// Design Name:   AutoBox
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/AorMtest.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AutoBox
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module AorMtest;

	// Inputs
	reg [31:0] pcin;
	reg control;
	reg add_push;
	reg reset;
	// Outputs
	wire [31:0] pcout;

	// Instantiate the Unit Under Test (UUT)
	AutoBox uut (
		.reset(reset),
		.pcin(pcin), 
		.control(control), 
		.add_push(add_push), 
		.pcout(pcout)
	);

	initial begin
		// Initialize Inputs
		pcin = 0;
		control = 0;
		add_push = 0;
		reset = 0;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
   
	always #20 add_push =~ add_push;
	always #173 pcin = pcin + 112;
	always #control #91 control =~control;
	
endmodule

