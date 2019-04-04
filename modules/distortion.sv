module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input threshold
	);
	
	logic signed [15:0] left_Local;
	logic signed [15:0] right_Local;
	
	always @(leftSampleIn)begin
		left_Local = leftSampleIn * 2;
		right_Local = rightSampleIn * 2;
		
		if(left_Local > 16'd24576)begin	//0.75
			leftSampleOut = 16'd24576;
		end
		else if(left_Local < -16'd24576)begin
			leftSampleOut = -16'd24576;
		end
		else begin
			leftSampleOut = left_Local;
		end
		
		if(right_Local > 16'd24576)begin
			rightSampleOut = 16'd24576;
		end
		else if(right_Local < -16'd24576)begin
			rightSampleOut = -16'd24576;
		end
		else begin
			rightSampleOut = right_Local;
		end
	end
endmodule
