//////////////////////////////////////////
// 										//
// Name: Mo'men Alaa Aldeen Abd Alkader //
// Track: Digital IC Design				//
// Group: 3								//
//										//
//////////////////////////////////////////

module testbench();
logic clk;
logic reset;
logic [31:0] WriteData, DataAdr;
logic MemWrite;
logic read_data;
logic ReadData;

 // instantiate device to be tested
RISCV_TOP dut
(	.clk_i(clk), 
	.reset_i(reset), 
	.WriteData_TEST(WriteData), 
	.DataAdr_TEST(DataAdr), 
	.MemWrite_TEST(MemWrite),
	.read_data_TEST(read_data),
	.ReadData_TEST(ReadData)
);


 // initialize test
 initial
	 begin
		reset <= 1; # 25; reset <= 0; 
	 end
 // generate clock to sequence tests
 always
	 begin
		clk <= 1; # 5; clk <= 0; # 5;
	 end
 // check results
 
 always @(negedge clk)
	 begin
			 if(MemWrite) begin
				 if(DataAdr == 'd50 && WriteData == 32'hfffff8ae) begin
					 # 50
					 $display("Simulation succeeded");
					 $stop;
					 end 
					 else if (DataAdr == 'd50 && WriteData != 32'hfffff8ae) begin
						 $display("Simulation failed");
						 $stop;
						end
			 end
	 end
endmodule