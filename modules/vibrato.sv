module vibrato(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,

	input signed [15:0] Q1,
	output signed [15:0] D1,
	output [15:0] write_address,
	output [15:0] read_address,
	
	input signed [15:0] Q2,
	output signed [15:0] D2,

	output W_E1,
	output W_E2,
	input ADCLRCK,

	input [31:0] sin
	);
	
	logic flag = 0;
	logic signed [15:0] sample = 0;
	logic [31:0] delay_time = 0;
	logic [31:0] old_delay_time = 0;
	logic [31:0] old_delay_time_2 = 0;
	logic [31:0] prevSin = 0;
	
	logic [31:0] new_delay_time = 0;
	
	logic write_buffer = 1;
	logic read_buffer = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D2 = leftSampleIn;
			leftSampleOut = leftSampleIn;
			rightSampleOut = leftSampleIn;
			write_address = 0;
			read_address = 0;
			flag = 1;
			
			W_E1 = 0;
			W_E2 = 1;
			
			prevSin = sin;
			delay_time = (240 * sin) >> 9;
			old_delay_time_2 = delay_time;
		end
		else begin
			if(sin != prevSin)begin
				new_delay_time = (240 * sin) >> 9;
			end
			prevSin = sin;
		
			if(write_address < delay_time)begin
				write_address = write_address + 1;
			end
			else begin
				write_address = 0;
				old_delay_time = delay_time;
				delay_time = new_delay_time;
				write_buffer = ~write_buffer;
				W_E1 = ~W_E1;
				W_E2 = ~W_E2;
			end
			
			if(read_address < old_delay_time_2)begin
				read_address = read_address + 1;
			end
			else begin
				read_address = 0;
				old_delay_time_2 = old_delay_time;
				read_buffer = ~read_buffer;
			end
			
			if(read_buffer == 0)begin
				sample = Q1;
			end
			else begin
				sample = Q2;
			end
				
			if(write_buffer == 0)begin
				D1 = leftSampleIn;
			end
			else begin
				D2 = leftSampleIn;
			end
			
			leftSampleOut = sample;
			rightSampleOut = sample;
		end
	end
	
endmodule
