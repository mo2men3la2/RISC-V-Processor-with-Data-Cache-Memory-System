module cache_mem #(localparam data_width=32, localparam miss_data_width=128,localparam address_width=7, localparam cache_depth=128)
(
	input	wire	clk,
	input	wire	reset,
	input	wire	refill,
	input	wire	update,
	input	wire	read,
	input	wire	[data_width-1:0]	wdata,
	input	wire	[miss_data_width-1:0]	miss_mm_data,
	input	wire	[address_width-1:0] index_offset,
	output	reg		[data_width-1:0]	rdata
);

	reg	[data_width-1:0] cache [0:cache_depth-1];
	

always @ (*) begin
	//if (read | refill)
		rdata = cache[index_offset];
	/*else
		rdata = 32'd0;*/
end

integer i;

always @ (posedge clk, posedge reset) begin
	if (reset) begin
		for (i=0; i<128; i=i+1) begin
			cache[i] <= 32'd0;
		end
	end	
	else if (update) 
		cache[index_offset] <= wdata;
	else if (refill) begin
		cache[{index_offset[address_width-1:2],2'b00}] <= miss_mm_data[31:0];
		cache[{index_offset[address_width-1:2],2'b01}] <= miss_mm_data[63:32];
		cache[{index_offset[address_width-1:2],2'b10}] <= miss_mm_data[95:64];
		cache[{index_offset[address_width-1:2],2'b11}] <= miss_mm_data[127:96];
	
		
	end		
end


endmodule