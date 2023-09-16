//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module mux_3x1 (
    input wire [31:0] data0,
    input wire [31:0] data1,
    input wire [31:0] data2,
    input wire [1:0] select,
    output wire [31:0] out
);
    assign out = (select == 2'b00) ? data0 :
                    (select == 2'b01) ? data1 :
                    (select == 2'b10) ? data2 :
                    32'b0;  // Default case
endmodule