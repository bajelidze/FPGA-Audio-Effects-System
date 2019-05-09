module main_7seg_controller(
	input [9:0] SW,
	input signed [15:0] gain,			//distortion
	input signed [31:0] threshold,
	
	input [31:0] tr_freq,			//tremolo
	
	input [31:0] ring_freq,			//ring mod

	input [31:0] echo_delay_time,		//echo
	input [31:0] echo_delay_volume,
	
	input [31:0] vib_freq,			//vibrato
	
	input [31:0] sb_delay_time,
	
	output [31:0] num0,
	output [31:0] num1,
	output [31:0] num2,
	output [31:0] num3,
	output [31:0] num4,
	output [31:0] num5
	);
	
	always @(SW)begin
		if(SW[3:0] == 0)begin
			num5 <= 0;
			num4 <= 11;
			
			if(threshold < 10000)begin
				num3 = threshold / 1000;
				if(num3 == 0) num3 = 10;
				num2 = (threshold / 100) % 10;
				if(num2 == 0 && num3 == 10) num2 = 10;
				num1 = (threshold / 10) % 10;
				num0 = threshold % 10;
			end
			else begin
				num3 = threshold / 10000;
				num2 = (threshold / 1000) % 10;
				num1 = 11;
				num0 = 11;
			end
		end
		else if(SW[3:0] == 1)begin
			num5 = 1;
			num4 = 11;
			
			num3 = 10;
			num2 = 10;
			num1 = (gain / 10) % 10;
			if(num1 == 0) num1 = 10;
			num0 = gain % 10;
		end
		else if(SW[3:0] == 2)begin
			num5 = 2;
			num4 = 11;
			
			num3 = 10;
			num2 = 10;
			num1 = ((97656 / tr_freq) / 10) % 10;
			if(num1 == 0) num1 = 10;
			num0 = (97656 / tr_freq) % 10;
		end
		else if(SW[3:0] == 3)begin
			num5 = 3;
			num4 = 11;
			
			num3 = (1562500 / ring_freq) / 1000;
			if(num3 == 0) num3 = 10;
			num2 = ((1562500 / ring_freq) / 100) % 10;
			if(num2 == 0 && num3 == 10) num2 = 10;
			num1 = ((1562500 / ring_freq) / 10) % 10;
			num0 = (1562500 / ring_freq) % 10;
		end
		else if(SW[3:0] == 4)begin
			num5 = 4;
			num4 = 11;
			num3 = 10;
			
			num2 = echo_delay_time / 48000;
			num1 = (((echo_delay_time * 100) / 48000) / 10) % 10;
			num0 = ((echo_delay_time * 100) / 48000) % 10;
		end
		else if(SW[3:0] == 5)begin
			num5 = 5;
			num4 = 11;
			num3 = 10;
			num2 = 10;
			num1 = 10;
			
			num0 = echo_delay_volume;
		end
		else if(SW[3:0] == 6)begin
			num5 = 6;
			num4 = 11;
			
			num3 = 10;
			num2 = 10;
			num1 = ((97656 / vib_freq) / 10) % 10;
			if(num1 == 0) num1 = 10;
			num0 = (97656 / vib_freq) % 10;
		end
		else if(SW[3:0] == 7)begin
			num5 = 7;
			num4 = 11;
			num3 = 10;
			
			num2 = sb_delay_time / 48000;
			num1 = (((sb_delay_time * 100) / 48000) / 10) % 10;
			num0 = ((sb_delay_time * 100) / 48000) % 10;
		end
		else begin
			num5 = 10;
			num4 = 10;
			num3 = 10;
			num2 = 10;
			num1 = 10;
			num0 = 10;
		end
	end
endmodule
