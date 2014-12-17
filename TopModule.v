`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:44:40 03/19/2014 
// Design Name: 
// Module Name:    TopModule 
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
module TopModule(
					input wire  showRorM,
					input wire	regcount,
					input wire	clk,
					input wire	reset,
					input wire	start,
					input wire	AorM,
					input wire	addpush,
					output wire [6:0]	led,
					output wire [3:0] led_select,
					output wire [7:0] light,
					output wire dot
					
    );
 
//clock signal
	wire clk2;
//control signal	
	wire PCcount;	
	wire MemWrite;
	wire IR_DR;
	wire RegWrite;
	wire [5:0] funct;
	wire [4:0] rout1;
	wire [4:0] rout2;
	wire [4:0] rin;
	
//mux&dec signal
	wire addr_mux;
	wire Din_mux;
	wire AddrOrData_mux;
	wire MemOrReg_mux;
	wire Store_mux;
	wire Imm_Mux;
	

//data wire	
	wire [31:0] PC1;
//	wire [31:0] PC2;
	wire next;
	
	wire [31:0] addr_imm;
	wire [31:0] imm;
	wire [31:0] addr;

	
	wire [31:0] A;
	wire [31:0] B;
	wire [31:0] C;
	wire [31:0] alu_a;
	
	wire [31:0] res_addr;
	wire [31:0] res_data_mem;
	wire [31:0] res_data_reg;
	wire [31:0] res_data;
	
	wire [31:0] InstrReg;
	wire [31:0] DataReg;
	
	wire [31:0] MemIn;
	wire [31:0] Din;
	
	wire [5:0] stage;
	
	wire [7:0] regoutans;
	wire [3:0] regoutnumber;
	wire [7:0] memoutans;
	wire [3:0] memoutnumber;
	
	wire [7:0] outans;
	wire [3:0] outnumber;
	
	wire overflow;
	wire [31:0] inter_addr;
	
	
	assign outans = showRorM?regoutans:memoutans;
	assign outnumber = showRorM?regoutnumber:memoutnumber;
	
//	assign controlclk = AorM?clk2:clk48;
	
	
	
	ClockUnit cccc (
    .clk(clk), 
	 .start(start),
    .reset(reset), 
    .clk2(clk2)
    );
	 
	 ControlBlock ControlUnit (
	 .PC(PC1),
	 .next(next),
	 .reset(reset),
    .IR(InstrReg), 
    .clk(clk2), 		//change another clock slower 100 times
    .regrs(A), 
    .regrt(B), 
	 .overflow(overflow),
	 .inter_addr(inter_addr),
    .IR_DR(IR_DR), 
    .MemWrite(MemWrite), 
    .funct(funct), 
    .rout1(rout1), 
    .rout2(rout2), 
    .rin(rin), 
    .imm(imm), 
    .addrmux(addr_mux), 
    .Dinmux(Din_mux), 
    .AddrOrDatamux(AddrOrData_mux), 
    .MemOrRegmux(MemOrReg_mux), 
    .Storemux(Store_mux), 
    .immmux(Imm_Mux), 
    .PCcount(PCcount), 
    .RegWrite(RegWrite), 
    .addr_imm(addr_imm),
	 .stage(stage)
    );


	 Memory MemoryUnit (
	 .push(regcount), 
    .addr(addr), 
    .WR(MemWrite), 
    .IR_DR(IR_DR), 
    .MDataIn(MemIn), 
    .clk(clk), 
    .reset(reset), 
    .IR(InstrReg), 
    .DR(DataReg),
	 .outans(memoutans), 
    .outnumber(memoutnumber),
	 .inter_addr(inter_addr)
    );
	 


	
/*	
	AutoBox auto (
	 .clk(clk),
	 .reset(reset),
    .pcin(PC1), 
    .control(AorM), 
    .add_push(addpush), 
    .pcout(PC2)
    );
*/
	ALU AluUnit (
    .clk(clk),
	 .funct(funct), 
    .INa(alu_a), 
    .INb(B), 
    .OUT(C),
	 .overflow(overflow)
    );
	 
	 RegSet RegisterSetUnit (
	 .reset(reset),
    .push(regcount),
	 .Din(Din), 
    .writable(RegWrite), 
    .rs(rout1), 
    .rt(rout2), 
    .rd(rin), 
    .clk(clk), 
    .outa(A), 
    .outb(B),
	 .outans(regoutans), 
    .outnumber(regoutnumber)
    );


 
	 PCBlock PcUnit (
    .control(AorM), 
    .push(addpush), 
    .clk(clk), 
    .inc(addr_imm), 
    .reset(reset), 
    .addcontrol(PCcount), 
    .addr(PC1),
	 .next(next)
    );

	 
	 MUX2 AddrMux (
    .in1(PC1), 
    .in2(C), 
//	 .in2(res_addr), 
    .control(addr_mux), 
    .out(addr)
    );
	 
	 MUX2 DinMux (
	 .in1(DataReg),
	 .in2(res_data_reg),
	 .control(Din_mux),
	 .out(Din)
	 );
	 
	 MUX2 ImmMux (
	 .in1(imm),
	 .in2(A),
	 .control(Imm_Mux),
	 .out(alu_a)
	 );
	 
	 MUX2 StoreMux (
	 .in1(A),
	 .in2(res_data_mem),
	 .control(Store_mux),
	 .out(MemIn)
	 );
	 
/*	 DEC2 AddrOrDataDec (
	 .control(AddrOrData_mux), 
    .in(C), 
    .out1(res_addr), 
    .out2(res_data)
    );*/
	 
	 DEC2 MemOrRegDec ( 
    .control(MemOrReg_mux), 
//    .in(res_data), 
	 .in(C),
    .out1(res_data_mem), 
    .out2(res_data_reg)
    );

	SevenSegLed SevenSeg (
    .clk(clk), 
    .in1(outans[3:0]), 
    .in2(outans[7:4]), 
    .in3(PC1[3:0]), 
    .in4(outnumber[3:0]),  
    .seg(led), 
    .an(led_select), 
    .dp(dot)
    );

		

	assign light = {2'b00,InstrReg[31:26]};
//	assign light =stage;
endmodule
