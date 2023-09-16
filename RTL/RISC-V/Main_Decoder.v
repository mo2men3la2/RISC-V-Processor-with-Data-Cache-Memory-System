//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module Main_Decoder #(parameter width =7)
(
input      [width-1:0] opcode,
output reg             Branch,
output reg             Jump,
output reg [1:0]       ResultSrc,
output reg             MemWrite,
output reg             ALUSrc,
output reg [1:0]       ImmSrc,
output reg             RegWrite,
output reg [1:0]       ALUOp
);

always @(*)
begin
 case(opcode)
	7'b0000011:begin
      RegWrite	=1'b1;    
      ImmSrc	=2'b00;
      ALUSrc	=1'b1;
      MemWrite  =1'b0;
      ResultSrc	=2'b01;
      Branch  	=1'b0;
      ALUOp		=2'b00;
      Jump   	=1'b0;
             end
	7'b0100011:begin
      RegWrite	=1'b0;    
      ImmSrc	=2'b01;
      ALUSrc	=1'b1;
      MemWrite  =1'b1;
      ResultSrc	=2'b00;
      Branch  	=1'b0;
      ALUOp		=2'b00;
      Jump   	=1'b0;
             end
	7'b0110011:begin
      RegWrite	=1'b1;    
      ImmSrc	=2'b00;
      ALUSrc	=1'b0;
      MemWrite  =1'b0;
      ResultSrc	=2'b00;
      Branch  	=1'b0;
      ALUOp		=2'b10;
      Jump   	=1'b0;
             end
	7'b1100011:begin
      RegWrite	=1'b0;    
      ImmSrc	=2'b10;
      ALUSrc	=1'b0;
      MemWrite  =1'b0;
      ResultSrc	=2'b00;
      Branch  	=1'b1;
      ALUOp		=2'b01;
      Jump   	=1'b0;
             end
	7'b0010011:begin
      RegWrite	=1'b1;    
      ImmSrc	=2'b00;
      ALUSrc	=1'b1;
      MemWrite  =1'b0;
      ResultSrc	=2'b00;
      Branch  	=1'b0;
      ALUOp		=2'b10;
      Jump   	=1'b0;
             end
	7'b1101111:begin
	  RegWrite	=1'b1;    
      ImmSrc	=2'b11;
      ALUSrc	=1'b0;
      MemWrite  =1'b0;
      ResultSrc	=2'b10;
      Branch  	=1'b0;
      ALUOp		=2'b00;
      Jump   	=1'b1;
             end
   default  :begin
      RegWrite	=1'b0;    
      ImmSrc	=2'b00;
      ALUSrc	=1'b0;
      MemWrite  =1'b0;
      ResultSrc	=2'b00;
      Branch  	=1'b0;
      ALUOp		=2'b00;
      Jump   	=1'b0;
             end
  
 endcase
end

endmodule