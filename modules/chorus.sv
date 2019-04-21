module chorus(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,

	input signed [15:0] Q1,
	output signed [15:0] D1,
	input signed [15:0] Q2,
	output signed [15:0] D2,
	output [15:0] write_address1,
	output [15:0] read_address1,
	output [15:0] write_address2,
	output [15:0] read_address2,
	output W_E,
	input ADCLRCK
	);
	
	logic flag = 0;
	logic signed [31:0] sample1 = 0;
	logic [31:0] delay_time1 = 0;
	logic signed [31:0] sample2 = 0;
	logic [31:0] delay_time2 = 0;
	
	//logic [31:0] new_delay_time = 0;
	
	logic [31:0] lsfr_32 = 123;
	logic [8:0] lsfr = 123;
	logic temp = 0;
	
	logic [31:0] lsfr_32_2 = 435;
	logic [8:0] lsfr_2 = 435;
	logic temp2 = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D1 = leftSampleIn;
			D2 = leftSampleIn;
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
			W_E = 1;
			write_address1 = 0;
			read_address1 = 0;
			write_address2 = 0;
			read_address2 = 0;
			flag = 1;
			
			delay_time1 = 480;
			delay_time2 = 480;
		end
		else begin
			if(write_address1 < delay_time1)begin
				write_address1 = write_address1 + 1;
				read_address1 = read_address1 + 1;
			end
			else begin
				write_address1 = 0;
				read_address1 = 0;
				
				//LSFR logic
				temp = lsfr[8] ^ lsfr[6] ^ lsfr[4];
				lsfr = lsfr << 1;
				lsfr[0] = temp;
				lsfr_32 = lsfr;
				
				temp2 = lsfr_2[8] ^ lsfr_2[6] ^ lsfr_2[4];
				lsfr_2 = lsfr_2 << 1;
				lsfr_2[0] = temp2;
				lsfr_32_2 = lsfr_2;
				
				delay_time1 = 480 + (720 * lsfr_32) >>> 9;
			end
			
			if(write_address2 < delay_time2)begin
				write_address2 = write_address2 + 1;
				read_address2 = read_address2 + 1;
			end
			else begin
				write_address2 = 0;
				read_address2 = 0;
				
				temp2 = lsfr_2[8] ^ lsfr_2[6] ^ lsfr_2[4];
				lsfr_2 = lsfr_2 << 1;
				lsfr_2[0] = temp2;
				lsfr_32_2 = lsfr_2;
				
				delay_time2 = 480 + (720 * lsfr_32_2) >>> 9;
			end
			
			sample1 = Q1;
			sample2 = Q2;
			
			leftSampleOut = leftSampleIn + sample1[15:0] + sample2[15:0];
			rightSampleOut = leftSampleIn + sample1[15:0] + sample2[15:0];
			
			D1 = leftSampleIn;
			D2 = leftSampleIn;
		end
	end
	
endmodule
