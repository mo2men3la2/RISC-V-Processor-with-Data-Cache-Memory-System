//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module register_file # (
    parameter Data_Width = 32,
              addres_width = 5  
)
(
input   wire            clk,
input   wire            rst,
input   wire            WE3,
input   wire    [addres_width - 1 :0]   A1,
input   wire    [addres_width - 1 :0]   A2,
input   wire    [addres_width - 1 :0]   A3,
input   wire    [Data_Width - 1:0]  WD3,
output  wire    [Data_Width - 1:0]  RD1,
output  wire    [Data_Width - 1:0]  RD2
);

parameter depth = (2**addres_width) -1;
reg [Data_Width - 1:0] reg_file [0:31] ;
integer i;


always @(posedge clk or posedge rst) 
begin
    if(rst)
        begin
            for(i = 0 ; i < (2**addres_width) ; i = i+1)
                reg_file[i] <= 0; 
        end
    else if (WE3)
        reg_file[A3] <= WD3;          
end

assign RD1 = reg_file [A1];
assign RD2 = reg_file [A2];

endmodule