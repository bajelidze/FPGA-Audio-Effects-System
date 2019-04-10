module tremolo(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input CLK
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;
	
	logic [31:0] counter = 0;
	logic CLK_Tr = 0;	//2kHz freq. of triangle wave
	
	logic signed [31:0] triangleNum = 1;
	logic direction = 0; //0 = down, 1 = up
	
	always @(posedge CLK)begin
		if(counter < 19531)begin //125k = 1 Hz, 10k = 12.5 Hz
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
			CLK_Tr <= ~CLK_Tr;
		end
	end
	
	// generates numerator of triangle, denum. is 100
	always @(posedge CLK_Tr)begin
		if(direction == 1)begin
			if(triangleNum < 128)begin
				triangleNum <= triangleNum + 1;
			end
			else begin
				direction <= 0;
				triangleNum <= triangleNum - 1;
			end
		end
		else begin
			if(triangleNum > 1)begin
				triangleNum <= triangleNum - 1;
			end
			else begin
				direction <= 1;
				triangleNum <= triangleNum + 1;
			end
		end
	end
	
	always @(leftSampleIn)begin
		left_Local = leftSampleIn;
		right_Local = rightSampleIn;
		
		left_Local = (left_Local * triangleNum) >>> 7;
		right_Local = (right_Local * triangleNum) >>> 7;
		
		leftSampleOut = left_Local[15:0];
		rightSampleOut = right_Local[15:0];
	end
	
endmodule
