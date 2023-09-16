//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module PCunit
    (
        input wire [31:0] PCNext,
        input wire clk, rst, stall,
        output reg [31:0] PC
    );
always @(posedge clk, posedge rst) 
begin
    if (rst) 
    begin
        PC <= 32'b0;
    end
    else if (!stall)
    begin
        PC <= PCNext;
    end
end
endmodule