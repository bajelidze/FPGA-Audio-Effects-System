module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input signed [15:0] gainNum,		//Numerator	0-128
	input signed [15:0] gainDen,	//Denominator 0-128
	input threshold
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;

	always @(leftSampleIn)begin
//		if(leftSampleIn < 0) leftSampleOut <= 0;
//		else leftSampleOut <= leftSampleIn;
//		
//		if(rightSampleIn < 0) rightSampleOut <= 0;
//		else rightSampleOut <= rightSampleIn;
//		
//		end
		left_Local <= (leftSampleIn * gainNum) / gainDen;
		right_Local <= (rightSampleIn * gainNum) / gainDen;
//		left_Local <= leftSampleIn << 4;
//		right_Local <= rightSampleIn << 4;
		
		if(left_Local > 24000)begin	//0.75
			leftSampleOut <= 16'd24000;
		end
		else if(left_Local < -24000)begin
			leftSampleOut <= -16'd24000;
		end
		else begin
			if(left_Local > 32767)begin
				leftSampleOut <= 16'd32767;
			end
			if(left_Local < -32768)begin
				leftSampleOut <= -16'd32768;
			end
			else begin
				leftSampleOut <= left_Local[15:0];
			end
		end
		
		if(right_Local > 24000)begin
			rightSampleOut <= 16'd24000;
		end
		else if(right_Local < -24000)begin
			rightSampleOut <= -16'd24000;
		end
		else begin
			if(right_Local > 32767)begin
				rightSampleOut <= 16'd32767;
			end
			if(right_Local < -32768)begin
				rightSampleOut <= -16'd32768;
			end
			else begin
				rightSampleOut <= right_Local[15:0];
			end
		end
	end
	
endmodule
