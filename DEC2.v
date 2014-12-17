`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:11:08 03/22/2014 
// Design Name: 
// Module Name:    DEC2 
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
module DEC2(
//			input clk,
			input control,
			input [31:0] in,
			output [31:0] out1,
			output [31:0] out2
    );

		assign out2 = control? in:out2;
		assign out1 = control? out1:in;

endmodule
