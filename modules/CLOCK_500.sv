`define rom_size 6'd8

module CLOCK_500(
	input CLOCK,
	output CLOCK_500,
	output [23:0] DATA,
	input END,
	input RESET,
	output GO,
	output CLOCK_2
	);

	logic [10:0] COUNTER_500;
	logic [15:0] ROM[`rom_size:0];
	logic [15:0] DATA_A;
	logic [5:0]	address;

	assign CLOCK_500 = COUNTER_500[9];
	assign CLOCK_2 = COUNTER_500[1];
	assign DATA = {8'h34, DATA_A};
	assign GO = ((address <= `rom_size) && (END == 1)) ? COUNTER_500[10] : 1;

	always @(negedge RESET or posedge END)begin
		if(!RESET)begin
			address = 0;
		end
		else if(address <= `rom_size)begin
			address = address + 1;
		end
	end

	logic [4:0] vol;
	logic [6:0] volume;

	always @(posedge RESET)begin
		vol = vol - 1;
	end
		
	assign volume = vol + 96;

	always @(posedge END)begin
		ROM[0] = 16'h0c00;	    				//power down
		ROM[1] = 16'h0e41;	   		   	//master 0ec2
		ROM[2] = 16'h0812;	    			 	//Mic muted, Bypass off, Line In, DAC sel
		ROM[8] = 16'h0a06;					 	//48kHz deemphazis
		ROM[3] = 16'h1000;					 	//mclk
		ROM[4] = 16'h0017;
		ROM[5] = 16'h0217;
		ROM[6] = {8'h04,1'b0,volume[6:0]};
		ROM[7] = {8'h06,1'b0,volume[6:0]};	//sound vol
		ROM[`rom_size] = 16'h1201;          //active
		
		DATA_A=ROM[address];
	end

	always @(posedge CLOCK)begin
		COUNTER_500 = COUNTER_500 + 1;
	end
	
endmodule
