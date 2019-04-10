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
	logic CLK_2kHz = 0;	//2kHz freq. of triangle wave
	
	logic signed [31:0] triangleNum = 1;
	logic direction = 0; //0 = down, 1 = up
	
	always @(posedge CLK)begin
		if(counter < 25000)begin
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
			CLK_2kHz <= ~CLK_2kHz;
		end
	end
	
	// generates numerator of triangle, denum. is 100
	always @(posedge CLK_2kHz)begin
		if(direction == 1)begin
			if(triangleNum < 100)begin
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
		
		left_Local = (left_Local * triangleNum) / 100;
		right_Local = (right_Local * triangleNum) / 100;
		
		leftSampleOut = left_Local[15:0];
		rightSampleOut = right_Local[15:0];
	end
	
endmodule
