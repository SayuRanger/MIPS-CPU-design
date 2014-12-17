`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:37:57 03/19/2014 
// Design Name: 
// Module Name:    ControlBlock 
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
module ControlBlock(
						input [31:0] PC,
						input next,
						input reset,
						input [31:0] IR,
						input clk,
						input [31:0] regrs,	//these are used to compare in BNZ 
						input [31:0] regrt,
						input overflow,
						input [31:0] inter_addr,
						output reg IR_DR,			//write memory data to IR or DR
						output reg MemWrite,		//set memory writable
						output reg [5:0] funct,	//ALU work state
						output  [4:0] rout1,		//select rs address
						output  [4:0] rout2,		//select rt address
						output  [4:0] rin,		//select rd address
						output reg [31:0] imm,	//expand from 16 bit to 32 bit
						
						output addrmux,		
						output Dinmux,
						output AddrOrDatamux,
						output MemOrRegmux,
						output Storemux,
						output immmux,
						
						output reg PCcount,		//change PCBlock value
						output reg RegWrite,		//set Register Set writable
						
						output reg [31:0] addr_imm,
						output [5:0] stage
	);
	 
	reg init = 1;
	reg addr_mux=0;		
	reg Din_mux=0;
	reg AddrOrData_mux=0;
	reg MemOrReg_mux=0;
	reg Store_mux=0;
	reg imm_mux=0;
	
	assign addrmux = addr_mux;
	assign Dinmux =Din_mux;
	assign AddrOrDatamux =AddrOrData_mux;
	assign MemOrRegmux =MemOrReg_mux;
	assign Storemux = Store_mux;
	assign immmux = imm_mux;
	
	reg [4:0] regout1 =0;
	reg [4:0] regout2 =0;
	reg [4:0] regin =0;
	
	wire [5:0] op_code;
	wire [5:0] op_code2;
	wire [31:0] immediate;
	wire [31:0] jump;

	
	assign rout1 = regout1;
	assign rout2 = regout2;
	assign rin = regin;
	
	assign op_code = IR [31:26];
	assign op_code2 = IR [5:0];
	assign immediate = {IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR[15],IR [15:0]};
//	assign jump = {IR[25],IR[25],IR[25],IR[25],IR[25],IR[25],IR[25:0]};
	
	assign jump = {IR[25],IR[25],IR[25],IR[25],IR[25],IR[25],IR[25:0]};
	
	reg [3:0] state =0;
	reg change = 1;
	
	assign stage = state;
	
	reg [1:0] PSW = 2'b00;			//PSW={INT,OVERFLOW}
	reg [33:0] AddrStack =0;			//AddrStack = {PSW,pc}
	reg [31:0] pcnow =0;

	
	
	parameter Add = 6'b100000;

	parameter fetch_instr = 0;
	parameter decode_instr = 1;
	parameter Rtype_instr = 2;
	parameter finish_instr =3;
	parameter lw = 4;
	parameter sw = 5;
	parameter beq = 6;
	parameter bne = 7;
	parameter addi = 8;
	parameter halt =9;
	parameter jmpend =10;
	parameter push =11;
	parameter pop =12;
	parameter getpcnow =13;
	parameter toint =14;
	parameter jo= 15;

/*	
	always @(posedge overflow)
	begin
		PSW[2] = overflow&PCcount;
	end
	
	always @(posedge PCcount)
	begin
		PSW[2] = overflow&PCcount;
	end	
	*/
	/*always @(posedge PCcount or posedge overflow)
	begin
		if()
	end*/
	
	always @(posedge clk)
	begin
	
	state <=(reset?1:init)?0:state;
	PCcount =(reset?1:init)?1:PCcount;
	addr_imm =(reset?1:init)?0:addr_imm;
	PSW =(reset?1:init)?0:PSW;
	init <= 0;
	
	
	
	case(state)
		fetch_instr:		//0000
		begin
			if((next&&change))
			begin
				PCcount =1;
				change <=0;
				PSW[0] = overflow;
			end
			else if(next&&(!change))
			begin
				change <= 1;
			end
		//	addr_imm=0;
			addr_mux =0;		
			Din_mux =0;
			AddrOrData_mux=0;
			MemOrReg_mux=0;
			Store_mux=0;
			state <= getpcnow;
//			jo_complete = pcrise?1:0;
			//state <= (PSW[3]&&(!interrupt))?check_interrupt:decode_instr;
		end
		
		getpcnow:			//1101
		begin
			IR_DR = 0;		//IR
			MemWrite = 1;
			RegWrite = 0;
			pcnow <=PC;
			state <= decode_instr;
		end
		
		decode_instr:		//0001
		begin
			addr_imm=0;
			regout1 = IR[15:11];
			regout2 = IR[20:16];
			regin = IR[25:21];
			imm = 0;			
			case(op_code)
			6'b000000:
			begin
				funct = op_code2;
				RegWrite =1;
				addr_mux = 0;
				Din_mux = 1;	//Accept data from register
				imm_mux = 1;		//choose A register
				AddrOrData_mux = 1;	//choose data bus
				MemOrReg_mux = 1;
				Store_mux = 1;
				state <= Rtype_instr;
			end
			
			6'b100011:			//lw
			begin
				funct = Add;
				addr_mux = 1;
				AddrOrData_mux = 0;
				Din_mux = 0;
				imm_mux = 0;			//choose imm number
				MemOrReg_mux = 1;
				imm = immediate;
				IR_DR = 1;
				state <= lw;
			end
			
			6'b101011:			//sw
			begin
				regout1 = IR[25:21];
				regout2 = IR[20:16];
				funct = Add;
				addr_mux = 1;
				Din_mux = 0;
				AddrOrData_mux = 0;
				Store_mux =0;
				imm_mux = 0;			//choose imm number
				MemOrReg_mux = 1;
				imm = immediate;
				RegWrite = 0;
				state <= sw;
			end
			
			6'b000100:		//beq
			begin
				regout1 = IR[25:21];		//rout1
				regout2 = IR[20:16];		//rout2
				//funct = 6'b111111;		//阻断alu
				state <= beq;
			end
			
			6'b000101:		//bne
			begin
				regout1 = IR[25:21];
				regout2 = IR[20:16];
				//funct = 6'b111111;		//阻断alu
				state <= bne;
			end
			
			6'b001000:		//addi
			begin
				funct =Add;
				addr_mux = 0;
				MemWrite =1;
				RegWrite =1;
				imm_mux =0;
				AddrOrData_mux =1;
				MemOrReg_mux =1;
				Din_mux = 1;
				imm =immediate;
				state <= finish_instr;
			end

			6'b000010:		//j
			begin
				//funct =6'b111111;
				addr_imm = jump;
				state <= finish_instr;
			end
			
			6'b000111:		//jo
			begin
				addr_imm = PSW[0]?jump:0;
				state <= finish_instr;
			end
			
			6'b100100:		//push
			begin
				RegWrite = 1;
				AddrStack <= {PSW,pcnow};		
				state <= finish_instr;
			end
			
			6'b011011:			//pop
			begin
				PSW = {0,AddrStack[32]};		//消除最高位中断位的信号
				addr_imm = AddrStack[31:0] - pcnow ;
				state <= finish_instr;
			end
			
			6'b011000:
			begin
				AddrStack <= {PSW,pcnow};
				addr_imm = inter_addr -pcnow-1;
				state <= finish_instr;
			end
			6'b100111:		//halt
			begin
				//funct =6'b111111;
				//PCcount =1;
				addr_imm = -1;
				state <= halt;
			end
			
			default:
				state <= finish_instr;
			endcase
			
		end
		
		Rtype_instr:
		begin
			addr_imm =0;			
			RegWrite =1;
			state <= finish_instr;
		end
		
		lw:
		begin
			MemWrite = 1;			//read out
			RegWrite = 1;			
			state <= finish_instr;
		end
		
		sw:
		begin
			MemWrite = 0;			//write in
			RegWrite = 0;		
			state <= finish_instr;
		end
		
		beq:
		begin
			if(regrs == regrt)
				addr_imm = immediate;
			else
				addr_imm = 32'b00000000000000000000000000000000;
			state <= finish_instr;
		end
		
		bne:
		begin
			if(regrs!=regrt)
				addr_imm = immediate;
			else
				addr_imm = 32'b00000000000000000000000000000000;
			state <= finish_instr;
		end
		
		finish_instr:
		begin
	//		PSW[1] = interrupt;
			
			MemWrite = 1;		//read
			RegWrite = 0;		//can't write to reg
			PCcount =0;
			state <= fetch_instr;
		end
		
		halt:
		begin
			PCcount =0;
			
			state <= fetch_instr;
		end
		
		default:
		begin
			state<= fetch_instr;
		end
	endcase
	end

	


endmodule
