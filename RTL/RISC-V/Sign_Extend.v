//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module Sign_Extend (
input      	[31:7]	Instr,
input		[1:0]	ImmSrc,  	
output reg 	[31:0]	ImmExt
);

always @(*)
begin
	case (ImmSrc)
		2'b00:	ImmExt = {{20{Instr[31]}},Instr[31:20]};
		2'b01:	ImmExt = {{20{Instr[31]}},Instr[31:25],Instr[11:7]};
		2'b10:	ImmExt = {{20{Instr[31]}},Instr[7],Instr[30:25],Instr[11:8],1'b0};
		2'b11:	ImmExt = {{12{Instr[31]}},Instr[19:12],Instr[20],Instr[30:21],1'b0};
	endcase
end

endmodule