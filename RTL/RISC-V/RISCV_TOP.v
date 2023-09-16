//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module RISCV_TOP
(
    input	clk_i, reset_i,
	output	[31:0] WriteData_TEST, DataAdr_TEST, 
	output MemWrite_TEST , read_data_TEST, ReadData_TEST
);




wire [31:0] PC_i, Instr_i, PCNext_i, Result_i, SrcA_i, SrcB_i, RD2_i, ImmExt_i, PCTarget_i, ALUResult_i, ReadData_i, PCPlus4_i;
wire [2:0] ALUControl_i;
wire [1:0] ResultSrc_i, ImmSrc_i;
wire RegWrite_i, Zero_i, MemWrite_i, ALUSrc_i, PCSrc_i, stall_i, read_data;

assign WriteData_TEST = RD2_i;
assign DataAdr_TEST = ALUResult_i;
assign MemWrite_TEST = MemWrite_i;
assign read_data_TEST = read_data;
assign ReadData_TEST = ReadData_i;

PCunit PCunit_i
(
	.PCNext(PCNext_i),
    .clk(clk_i), 
	.rst(reset_i),
	.stall(stall_i),
    .PC(PC_i)
);

Instruction_Memory Instruction_Memory_i
(
	.A(PC_i),
	.RD(Instr_i)
);

register_file register_file_i
(
	.clk(clk_i),
	.rst(reset_i),
	.WE3(RegWrite_i),
	.A1(Instr_i[19:15]),
	.A2(Instr_i[24:20]),
	.A3(Instr_i[11:7]),
	.WD3(Result_i),
	.RD1(SrcA_i),
	.RD2(RD2_i)
);

assign read_data = (Instr_i[6:0] == 7'b0000011) ? 1'b1: 1'b0;

Control_Unit Control_Unit_i
(
	.funct3(Instr_i[14:12]),
	.funct7(Instr_i[30]),
	.op(Instr_i[6:0]),
	.Zero(Zero_i),
	.MemWrite(MemWrite_i),
	.ResultSrc(ResultSrc_i),
	.ALUSrc(ALUSrc_i),
	.ImmSrc(ImmSrc_i),
	.RegWrite(RegWrite_i),
	.ALUControl(ALUControl_i),
	.PCSrc(PCSrc_i)
);

Sign_Extend Sign_Extend_i
(
	.Instr(Instr_i[31:7]),
	.ImmSrc(ImmSrc_i),  	
	.ImmExt(ImmExt_i)
);

mux_2x1 mux_2x1_i_0
(
	.D0(RD2_i), 
	.D1(ImmExt_i), 
	.S(ALUSrc_i),
	.Y(SrcB_i)
);

mux_2x1 mux_2x1_i_1
(
	.D0(PCPlus4_i), 
	.D1(PCTarget_i), 
	.S(PCSrc_i),
	.Y(PCNext_i)
);

Adder Adder_i_0
(
	.A(PC_i),
	.B(ImmExt_i),
	.C(PCTarget_i)
);

Adder Adder_i_1
(
	.A(PC_i),
	.B(32'd4),
	.C(PCPlus4_i)
);

ALUunit ALUunit_i
(
    .SrcA(SrcA_i), 
	.SrcB(SrcB_i),
    .ALUControl(ALUControl_i),
    .ALUResult(ALUResult_i),
    .Zero(Zero_i)
);

/*DataMem DataMem_i
(
	.A(ALUResult_i),
	.WD(RD2_i),
	.we(MemWrite_i), 
	.clk(clk_i),
	.rst(reset_i),
	.RD(ReadData_i)
);*/


data_mem_sys cache_data_system 
(
 .clk(clk_i),
 .rst(reset_i),
 .MemRead(read_data),
 .MemWrite(MemWrite_i),
 .WordAddress(ALUResult_i[9:0]),
 .DataIn(RD2_i),
 .Stall(stall_i),
 .DataOut(ReadData_i)
 
);

mux_3x1 mux_3x1_i
(
	.data0(ALUResult_i),
    .data1(ReadData_i),
    .data2(PCPlus4_i),
    .select(ResultSrc_i),
    .out(Result_i)
);

endmodule
