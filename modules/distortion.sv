module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input signed [15:0] gain,		//Numerator	0-128
	input signed [31:0] threshold,
	input [1:0] mode //0 - OFF, 1/3 - Distortion ON, 2 - Rectifier Distortion ON
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;

	always @(leftSampleIn)begin
		if(mode == 0)begin			//OFF
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
		end
		else if(mode == 1 || mode == 3)begin		// Distortion ON
//			left_Local <= leftSampleIn * gain;
//			right_Local <= rightSampleIn * gain;
//			
//			if(left_Local > threshold)begin
//				leftSampleOut <= threshold[15:0];
//			end
//			else if(left_Local < -threshold)begin
//				leftSampleOut <= -threshold[15:0];
//			end
//			else begin
//				if(left_Local > 32767)begin
//					leftSampleOut <= 16'd32767;
//				end
//				if(left_Local < -32768)begin
//					leftSampleOut <= -16'd32768;
//				end
//				else begin
//					leftSampleOut <= left_Local[15:0];
//				end
//			end
//			
//			if(right_Local > threshold)begin
//				rightSampleOut <= threshold[15:0];
//			end
//			else if(right_Local < -threshold)begin
//				rightSampleOut <= -threshold[15:0];
//			end
//			else begin
//				if(right_Local > 32767)begin
//					rightSampleOut <= 16'd32767;
//				end
//				if(right_Local < -32768)begin
//					rightSampleOut <= -16'd32768;
//				end
//				else begin
//					rightSampleOut <= right_Local[15:0];
//				end
//			end

			left_Local = leftSampleIn;
			right_Local = rightSampleIn;
			
			if(left_Local > threshold)begin
				left_Local = threshold * gain;
				leftSampleOut = left_Local[15:0];
			end
			else if(left_Local < -threshold)begin
				left_Local = -threshold * gain;
				leftSampleOut = left_Local[15:0];
			end
			else begin
				left_Local = left_Local * gain;
				leftSampleOut = left_Local[15:0];
			end
			
			if(right_Local > threshold)begin
				right_Local = threshold * gain;
				rightSampleOut = right_Local[15:0];
			end
			else if(right_Local < -threshold)begin
				right_Local = -threshold * gain;
				rightSampleOut = right_Local[15:0];
			end
			else begin
				right_Local = right_Local * gain;
				rightSampleOut = right_Local[15:0];
			end
		end
		else if(mode == 2)begin			//Rectifier Distortion ON
			if(leftSampleIn < 0) leftSampleOut <= 0;
			else begin
				leftSampleOut = leftSampleIn;
			end
			if(rightSampleIn < 0)begin
				rightSampleOut = 0;
			end
			else begin
				rightSampleOut = rightSampleIn;
			end
		end
	end
endmodule
