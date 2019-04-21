module chorus(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,

	input signed [15:0] Q,
	output signed [15:0] D,
	output [15:0] write_address,
	output [15:0] read_address,
	output W_E,
	input ADCLRCK
	);
	
	logic flag = 0;
	logic signed [31:0] sample = 0;
	logic [31:0] delay_time = 0;
	
	//logic [31:0] new_delay_time = 0;
	
	logic [31:0] lsfr_32 = 123;
	logic [8:0] lsfr = 123;
	logic temp = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D = leftSampleIn;
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
			W_E = 1;
			write_address = 0;
			read_address = 0;
			flag = 1;
			
			delay_time = 480;
		end
		else begin	
			if(write_address < delay_time)begin
				write_address = write_address + 1;
				read_address = read_address + 1;
			end
			else begin
				write_address = 0;
				read_address = 0;
				
				//LSFR logic
				temp = lsfr[8] ^ lsfr[6] ^ lsfr[4];
				lsfr = lsfr << 1;
				lsfr[0] = temp;
				lsfr_32 = lsfr;
				
				delay_time = 480 + (720 * lsfr_32) >>> 9;
			end
			
			sample = Q;
			
			leftSampleOut = sample[15:0];
			rightSampleOut = sample[15:0];
			
			D = leftSampleIn;
		end
	end
	
endmodule
