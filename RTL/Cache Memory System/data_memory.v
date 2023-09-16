module data_memory #(localparam data_width=32, localparam miss_data_width=128,localparam address_width=10, localparam mem_depth=1024)
(
	input	wire	clk,
	input	wire	reset,
	input	wire	write,
	input	wire	read,
	input	wire	[data_width-1:0]	wdata,
	input	wire	[address_width-1:0]	addr,
	output	reg		[miss_data_width-1:0]	miss_mm_data,
	output	reg		ready
);

	reg [data_width-1:0] data_ram [0:mem_depth-1];
	reg	[1:0]	counter;
	integer i;
	
always @ (*) begin
	if (read)
		miss_mm_data = {data_ram[{addr[address_width-1:2],2'b11}],data_ram[{addr[address_width-1:2],2'b10}],data_ram[{addr[address_width-1:2],2'b01}],data_ram[{addr[address_width-1:2],2'b00}]};	
	else
		miss_mm_data = 32'd0;
end	
	
	
always @(posedge clk, posedge reset) begin
	if (reset) begin
		for (i=0; i<1024; i=i+1) begin
			data_ram[i] <= 32'd0;
		end
		ready <= 1'b0;
		counter	<= 2'd0;
	end
	else if (read) begin
		ready <= 1'b0;
		counter <= counter + 1'b1;
		if (counter == 2'b11) begin
			ready <= 1'b1;
			counter <= 2'd0;
		end	
		else begin
		ready <= 1'b0;		
		end
	end	
	else if (write) begin		
		ready <= 1'b0;
		data_ram[addr] <= wdata;
		counter <= counter + 1'b1;
		if (counter == 2'b11) begin
			ready <= 1'b1;
			counter <= 2'd0;
		end	
		else begin
			ready <= 1'b0;
		end				
	end
	else
		ready <= 1'b0;
end

endmodule