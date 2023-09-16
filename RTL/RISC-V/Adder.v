//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module Adder (
input   wire [31:0]     A,
input   wire [31:0]     B,
output  reg  [31:0]     C
);

always @ (*)
begin
  C = A + B;
end

endmodule
