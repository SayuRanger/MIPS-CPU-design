`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:53:17 03/24/2014 
// Design Name: 
// Module Name:    x7seg 
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
module x7seg(
    input wire [15:0] x,
    input wire clk,
    input wire clr,
    output reg[6:0] a_to_g,
    output reg[3:0] an
    );
    reg[1:0] s;
	 reg[3:0] digit;
	 wire[3:0] aen;

	always @(posedge clk or posedge clr)
		begin 
		    if(clr == 1)
			    s <=0;
			  else
			     s <= s + 1;
		end
	 
	 ////4Î»4Ñ¡1£ºmux44
	 always @(*)
	 case(s)
	     0: digit = x[3:0];
		  1: digit = x[7:4];
		  2: digit = x[11:8];
		  3: digit = x[15:12];
	 endcase
	 
	 ////7¶ÎÒëÂëÆ÷£ºhex7seg
	 always @(*)
	 case(digit)
	   4'b0001: a_to_g= 7'b1111001;
		4'b0010: a_to_g= 7'b0100100;
		4'b0011: a_to_g= 7'b0110000;
		4'b0100: a_to_g= 7'b0011001;
		4'b0101: a_to_g= 7'b0010010;
		4'b0110: a_to_g= 7'b0000010;
		4'b0111: a_to_g= 7'b1111000;
		4'b1000: a_to_g= 7'b0000000;
		4'b1001: a_to_g= 7'b0010000;
		4'b1010: a_to_g= 7'b0001000;
		4'b1011: a_to_g= 7'b0000011;
		4'b1100: a_to_g= 7'b1000110;
		4'b1101: a_to_g= 7'b0100001;
		4'b1110: a_to_g= 7'b0000110;
		4'b1111: a_to_g= 7'b0001110;
		default: a_to_g= 7'b1000000;
	   endcase 
		////digit slect 
		always @(*)
		begin
         an = 4'b1111;
         if(aen[s] ==1)
             an[s] = 0;
      end
		////clock divider
		
endmodule
