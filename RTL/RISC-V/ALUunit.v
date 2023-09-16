//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module ALUunit
    (
        input wire [31:0] SrcA, SrcB,
        input wire [2:0] ALUControl,
        output reg [31:0] ALUResult,
        output reg Zero
    );
always @(*) 
begin
    case (ALUControl)
        3'b000: ALUResult = SrcA + SrcB;
        3'b001: ALUResult = SrcA - SrcB;
        3'b010: ALUResult = SrcA & SrcB;
        3'b011: ALUResult = SrcA | SrcB;
        3'b101: if (SrcA < SrcB)ALUResult = 32'd1; else ALUResult = 32'd0;
        default: ALUResult = 32'd0;
    endcase    
    Zero = ~|(ALUResult);
end
endmodule