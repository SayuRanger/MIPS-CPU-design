`timescale 1ps / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:11:37 03/26/2014
// Design Name:   RegSet
// Module Name:   C:/Users/John/Desktop/MipsCpuDesign/MIPS/regtest.v
// Project Name:  MIPS
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: RegSet
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module regtest;

	// Inputs
	reg reset;
	reg push;
	reg [31:0] Din;
	reg writable;
	reg [4:0] rs;
	reg [4:0] rt;
	reg [4:0] rd;
	reg clk;

	// Outputs
	wire [31:0] outa;
	wire [31:0] outb;
	wire [31:0] outans;
	wire [3:0] outnumber;

	// Instantiate the Unit Under Test (UUT)
	RegSet uut (
		.reset(reset), 
		.push(push), 
		.Din(Din), 
		.writable(writable), 
		.rs(rs), 
		.rt(rt), 
		.rd(rd), 
		.clk(clk), 
		.outa(outa), 
		.outb(outb), 
		.outans(outans), 
		.outnumber(outnumber)
	);

	initial begin
		// Initialize Inputs
		reset = 0;
		push = 0;
		Din = 12;
		writable = 1;
		rs = 5'b00001;
		rt = 5'b00011;
		rd = 5'b00010;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		#1000 reset =~reset;
		#100 reset =~reset;
	end
      always #1 clk=~clk;
		
endmodule

