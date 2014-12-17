`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:56:02 03/19/2014 
// Design Name: 
// Module Name:    MUX2 
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
module MUX2(
			input wire	[31:0] in1,
			input wire  [31:0] in2,
			input	wire	control,
			output wire	[31:0] out 
    );
	
	
	assign out = (control==1'b0) ? in1 : in2;

endmodule
