//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module mux_2x1 #(parameter width =32)
(
input wire [width-1:0]  D0, D1, 
input wire S,
output wire [width-1:0] Y
);
assign Y = (S) ? D1:D0 ;
endmodule