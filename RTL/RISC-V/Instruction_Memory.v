//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module Instruction_Memory (
input   wire [31:0]  A,
output  reg  [31:0]  RD
);
   parameter depth = (2**32) -1;



reg  [31:0] MEM [0:10000];


initial
begin
  $readmemh("riscvtest.txt",MEM);
end

always @(*)
begin
  RD = MEM [A>>2] ;
end

endmodule

