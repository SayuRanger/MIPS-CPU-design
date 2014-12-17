`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:15:25 03/19/2014 
// Design Name: 
// Module Name:    PCBlock 
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
module PCBlock(
				input control,
				input push,
				input clk,
				input [31:0] inc,
				input reset,
				input addcontrol,
				output [31:0] addr,
				output next
				
    );
	 reg nex =1;
	 reg change =1;
	/// reg change =0;
	 reg [31:0] address = -1;
	
	assign next =nex;
	assign addr = address;
	always @(posedge clk )
	begin
		address <=(reset == 1)?0:address;
		begin
		if((control?1:push)&&addcontrol&&change)		//
		begin
			address <= addr+inc+1;
			change <= 0;
		end
		else if((control?1:!push)&&(~addcontrol)&&(~change))
		begin
			change <= 1;
			nex <= 1;
		end
		
		if(push&&(!nex))
		begin
			nex <=1;
		end
		else if((!(control?1:push))&&(nex))
		begin
			nex <=0;
		end

		end
	end

	
endmodule
