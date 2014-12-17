`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:56:16 03/24/2014 
// Design Name: 
// Module Name:    bin2bcd 
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
module bin2bcd(
    input wire [13:0] b,
    output reg [16:0] p
    );
   ////
	reg [32:0] z;
	integer i;
	always @(*)
	begin
	  for(i=0; i<=32;i=i+1)
	    z[i]=0;
	  z[16:3] = b;
	  repeat(11)
	  begin
	     if(z[17:14]>4)
		     z[17:14] = z[17:14] + 3;
		  if(z[21:18]>4)
		     z[21:18] = z[21:18] + 3;
         if(z[25:22]>4)
		     z[25:22] = z[25:22] + 3;
         if(z[29:26]>4)
		     z[29:26] = z[29:26] + 3;	
         z[32:1] = z[31:0];			  
	  end
	  p = z[30:14]; /////BCD output.
	end

endmodule