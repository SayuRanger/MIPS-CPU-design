`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:31 03/25/2014 
// Design Name: 
// Module Name:    AutoBox 
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
module AutoBox(
				input clk,
				input reset,
				input [31:0] pcin,
				input control,
				input add_push,
				output reg [31:0] pcout
    );
	reg [31:0] last;
	reg change;
	
	always @(posedge clk)
	begin
		if(reset)
		begin
			change <=1;
			last <= 0;
			pcout <= 0;
		end
		
		case(control)
		1'b0:				//mamual
		begin
			if(change&&add_push)
			begin
				change<=0;
				pcout <= pcin;
				last <= pcin;
			end
			else if((!change)&&(!add_push))
			begin
				change <=1;
				pcout <= last;
			end
		end
		1'b1:				//auto
		begin
			pcout <= pcin;
		end
		endcase
	end


endmodule
