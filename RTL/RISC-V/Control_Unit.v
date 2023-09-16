//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module Control_Unit #(parameter width =7)
(
input  [2:0] 	   funct3,
input   	 	   funct7,
input  [width-1:0] op,
input     	       Zero,
output             MemWrite,
output [1:0]	   ResultSrc,
output             ALUSrc,
output [1:0]	   ImmSrc,
output             RegWrite,
output [2:0]       ALUControl,
output             PCSrc
);

wire   [1:0]       ALUOp;
wire			   Jump;
wire			   Branch;
assign PCSrc = (Zero & Branch)|Jump;


 Main_Decoder main_decoder (
 .opcode(op),
 .Jump(Jump) ,   
 .MemWrite(MemWrite), 
 .Branch(Branch) ,
 .ALUSrc(ALUSrc) ,
 .RegWrite(RegWrite), 
 .ALUOp(ALUOp),
 .ImmSrc(ImmSrc),
 .ResultSrc(ResultSrc)
 );


ALU_Decoder alu_decoder (
.funct3(funct3),
.funct7(funct7),   
.op5(op[5]), 
.ALUOp(ALUOp), 
.ALUControl(ALUControl)
);

endmodule