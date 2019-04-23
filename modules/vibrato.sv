module vibrato(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,

	input signed [15:0] Q,
	output signed [15:0] D,
	output [15:0] write_address,
	output [15:0] read_address,
	output W_E,
	input ADCLRCK,
//	input disabled,

	input [31:0] sin
	);
	
	logic flag = 0;
	logic signed [31:0] sample = 0;
	logic [31:0] delay_time = 0;
	logic [31:0] prevSin = 0;
	
	logic [31:0] new_delay_time = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D = leftSampleIn;
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
			W_E = 1;
			write_address = 0;
			read_address = 0;
			flag = 1;
			
			prevSin = sin;
			delay_time = (240 * sin) >> 9;
		end
		else begin
			if(sin != prevSin)begin
				new_delay_time = (240 * sin) >> 9;
			end
			prevSin = sin;
		
			if(write_address < delay_time)begin
				write_address = write_address + 1;
				read_address = read_address + 1;
			end
			else begin
				write_address = 0;
				read_address = 0;
				delay_time = new_delay_time;
			end
			
			sample = Q;
			
			leftSampleOut = sample[15:0];
			rightSampleOut = sample[15:0];
			
			D = leftSampleIn;
		end
	end
	
endmodule
