`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:20:13 03/26/2014 
// Design Name: 
// Module Name:    add 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module add(
		input [31:0] a,
		input [31:0] b,
		output [31:0] c
	
    );

		assign c = a+b;

endmodule
