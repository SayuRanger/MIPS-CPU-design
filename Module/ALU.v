`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:52:18 03/20/2014 
// Design Name: 
// Module Name:    ALU 
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
module ALU (
			input [5:0] funct,
			input [31:0] INa,
			input [31:0] INb,
			input clk,
			output [31:0] OUT,
			output overflow
    );
	 reg [33:0] a =0;
	 reg [33:0] b =0;
	 reg [33:0] c =0;
	 
	 reg over =0;
	 reg  state =0;
	 
	 assign OUT = c;
	 assign overflow = over;
	 initial 
	 begin
		state = 2'b00;
	 end 
	 
	 always @(posedge clk )
	 begin
		case(state)
		0:
		begin
			over = 0;
			a = {0,0,INa};
			b = {0,0,INb};
			state <= 2'b01;
		end
		1:
		begin
			case(funct)
			6'b000000:
			begin
				c <=0;
			end
			6'b100000:		//add
			begin
				c <= a+b;
				over = c[33]^c[32];
			end
			6'b100010:		//sub
			begin
				c <= a-b;
				over = c[33]^c[32];
			end		
			6'b100100:		//and
			begin
				c <= a & b;
			end
			6'b100101:		//or
			begin
				c <= a|b;
			end
			6'b101010:		//slt
			begin
				if(a<b)
					c <= 32'b00000000000000000000000000000001;
				else
					c <= 32'b00000000000000000000000000000000;
			end
			default:
				c <= 32'bzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz;
			endcase
			state <= 2'b00;
		end
		default:
			state <= 2'b00;
		endcase
	 end


endmodule
