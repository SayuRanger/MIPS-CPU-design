`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:34:21 03/19/2014 
// Design Name: 
// Module Name:    RegSet 
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
module RegSet(
			input reset,
			input push,
			input [31:0] Din,
			input writable,
			input [4:0] rs,
			input [4:0] rt,
			input [4:0] rd,
			input clk,
			output [31:0] outa,
			output [31:0] outb,
			output [7:0] outans,
			output [3:0] outnumber
    );

	reg [31:0] s0 =0;
	reg [31:0] s1 =1;
	reg [31:0] s2 =2;
	reg [31:0] s3 =3;
	reg [31:0] s4 =4;
	reg [31:0] s5 =5;
	reg [31:0] s6 =6;
	reg [31:0] s7 =7;
	
	reg [31:0] a =0;
	reg [31:0] b =0;
	
	reg [2:0] count =0;
	reg [7:0] aout =0;
	
	assign outans = aout;
	assign outnumber = {0,count};
	assign outa = a;
	assign outb = b;
/*	
	initial
	begin
		s0 = 32'b00000000000000000000000000000000;
		s1 = 32'b00000000000000000000000000000000;
		s2 = 32'b00000000000000000000000000000000;
		s3 = 32'b00000000000000000000000000000000;
		s4 = 32'b00000000000000000000000000000000;
		s5 = 32'b00000000000000000000000000000000;
		s6 = 32'b00000000000000000000000000000000;
		s7 = 32'b00000000000000000000000000000000;
	end
*/
	always @(posedge push)
	begin
		count =count+1;
	end

	
	always @(posedge push)
	begin
		case(count)
		3'b000:aout = s1[7:0];
		3'b001:aout = s2[7:0];
		3'b010:aout = s3[7:0];
		3'b011:aout = s4[7:0];
		3'b100:aout = s5[7:0];
		3'b101:aout = s6[7:0];
		3'b110:aout = s7[7:0];
		3'b111:aout = s0[7:0];
		endcase
	end
	
	always @(posedge clk)
	begin
		if(reset)
		begin
			s0 <=0;
			s1 <=1;
			s2 <=2;
			s3 <=3;
			s4 <=4;
			s5 <=5;
			s6 <=6;
			s7 <=7;
		end
		
		case(rs)
		5'b00000:
			a= s0;
		5'b00001:
			a= s1;
		5'b00010:
			a= s2;
		5'b00011:
			a= s3;
		5'b00100:
			a= s4;
		5'b00101:
			a= s5;
		5'b00110:
			a= s6;
		5'b00111:
			a= s7;
		endcase
		
		
		case(rt)
		5'b00000:
			b= s0;
		5'b00001:
			b= s1;
		5'b00010:
			b= s2;
		5'b00011:
			b= s3;
		5'b00100:
			b= s4;
		5'b00101:
			b= s5;
		5'b00110:
			b= s6;
		5'b00111:
			b= s7;
		endcase
		
		if(writable)
		begin
			case(rd)
			5'b00000:
				;
			5'b00001:
				s1 <= Din;
			5'b00010:
				s2 <= Din;
			5'b00011:
				s3 <= Din;
			5'b00100:
				s4 <= Din;
			5'b00101:
				s5 <= Din;
			5'b00110:
				s6 <= Din;
			5'b00111:
				s7 <= Din;
			endcase
		end
	end
	

endmodule
