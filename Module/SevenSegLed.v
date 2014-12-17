`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:22:09 03/25/2014 
// Design Name: 
// Module Name:    SevenSegLed 
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
module SevenSegLed(
					input clk,
					input [3:0] in1,
					input [3:0] in2,
					input [3:0] in3,
					input [3:0] in4,
					output [6:0] seg,
					output [3:0] an,
					output dp
    );
	 

	reg[3:0] num =0;
	reg[3:0] t_an =4'b1111;
	reg[6:0] t_seg =7'b1111111;
	reg[17:0] count =0;

	assign dp = 1;
	assign seg = t_seg;
	assign an = t_an;
	

always @(posedge clk)
		
		count=count+1;
		
	always @(count)
		begin
			t_an = 4'b1111;
			t_an[count[17:16]] =1'b0;
	//		t_an[count[1:0]] =1'b0;
		end

	always @(t_an)
		case(t_an)
			4'b1110: num = in1;			//1
			4'b1101:num = in2;				//2
			4'b1011: num = in3;			//3
			4'b0111: num = in4;				//4
		endcase
		
	always @(num)
	begin
		case(num)
			4'b0000: t_seg= 7'b0000001;
			4'b0001: t_seg= 7'b1001111;
			4'b0010: t_seg= 7'b0010010;
			4'b0011: t_seg= 7'b0000110;
			4'b0100: t_seg= 7'b1001100;
			4'b0101: t_seg= 7'b0100100;
			4'b0110: t_seg= 7'b0100000;
			4'b0111: t_seg= 7'b0001111;
			4'b1000: t_seg= 7'b0000000;
			4'b1001: t_seg= 7'b0000100;
			4'b1010: t_seg= 7'b0001000;
			4'b1011: t_seg= 7'b1100000;
			4'b1100: t_seg= 7'b0110001;
			4'b1101: t_seg= 7'b1000010;
			4'b1110: t_seg= 7'b0110000;
			4'b1111: t_seg= 7'b0111000;
			default: t_seg= 7'b1111111;
		endcase
	end


endmodule
