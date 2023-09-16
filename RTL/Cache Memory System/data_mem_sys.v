

module data_mem_sys 
(
 input   wire                  clk,rst,
 input   wire                  MemRead,MemWrite,
 input   wire     [9:0]        WordAddress,
 input   wire     [31:0]       DataIn,
 output  wire                  Stall,
 output  wire     [31:0]       DataOut
 
);

//*************** internal signals ***************//

wire            ready_c,
                refill_c,
                update_c,
                write_c,
                read_c,
                stall_c,
                hit_c;
wire   [127:0]   miss_mm_data_c;         


//*************** PORT MAPING ***************//
cache_controller  U0_cache_controller(
    .clk(clk),
    .rst(rst),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .ready(ready_c),
    .tag(WordAddress[9:7]),
    .index(WordAddress[6:2]),
    .refill(refill_c),
    .update(update_c),
    .write(write_c),
    .read(read_c),    
    .stall(stall_c),
    .cache_read(hit_c) 
);

data_memory U0_data_memory (
    .clk(clk),
	.reset(rst),
	.write(write_c),
	.read(read_c),
	.wdata(DataIn),
	.addr(WordAddress),
	.miss_mm_data(miss_mm_data_c),
	.ready(ready_c)
);

cache_mem cache_mem_i 
(
	.clk(clk),
	.reset(rst),
	.refill(refill_c),
	.update(update_c),
	.read(hit_c),
	.wdata(DataIn),
	.miss_mm_data(miss_mm_data_c),
	.index_offset(WordAddress[6:0]),
	.rdata(DataOut)
);

assign Stall = stall_c ;

endmodule