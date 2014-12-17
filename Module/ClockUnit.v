`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:04:00 03/22/2014 
// Design Name: 
// Module Name:    ClockUnit 
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
module ClockUnit(
					input start,
					input clk,
					input reset,
					output clk2
    );
	 
	reg [1:0] q =0;
	
	always @(posedge clk or posedge reset)
	begin
		q<= reset?0:(start?q+1:q);
	end

	
	//when impement
	assign clk2 = q[1];
	//when simulation
//	assign clk2 =q[0];
//	assign clk48=q[0];


endmodule
