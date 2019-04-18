module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input signed [15:0] gain,		//Numerator	0-128
	input signed [31:0] threshold, //20-32k, 50 default
	input disabled
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;

	always @(leftSampleIn)begin
		if(disabled == 1)begin			//OFF
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
		end
		else if(disabled == 0)begin		// Distortion ON
			left_Local = leftSampleIn;
			right_Local = rightSampleIn;
			
			if(left_Local > threshold)begin
				left_Local = threshold * gain;
				
				if(left_Local > 32767)begin
					leftSampleOut = 16'd32767;
				end
				else begin
					leftSampleOut = left_Local[15:0];
				end
			end
			else if(left_Local < -threshold)begin
				left_Local = -threshold * gain;
				
				if(left_Local < -32768)begin
					leftSampleOut = -16'd32768;
				end
				else begin
					leftSampleOut = left_Local[15:0];
				end
			end
			else begin
				left_Local = left_Local * gain;
				
				if(left_Local > 32767)begin
					leftSampleOut = 16'd32767;
				end
				if(left_Local < -32768)begin
					leftSampleOut = -16'd32768;
				end
				else begin
					leftSampleOut = left_Local[15:0];
				end
			end
			
			if(right_Local > threshold)begin
				right_Local = threshold * gain;
				
				if(right_Local > 32767)begin
					rightSampleOut = 16'd32767;
				end
				else begin
					rightSampleOut = right_Local[15:0];
				end
			end
			else if(right_Local < -threshold)begin
				right_Local = -threshold * gain;
				
				if(right_Local < -32768)begin
					rightSampleOut = -16'd32768;
				end
				else begin
					rightSampleOut = right_Local[15:0];
				end
			end
			else begin
				right_Local = right_Local * gain;
				
				if(right_Local > 32767)begin
					rightSampleOut = 16'd32767;
				end
				if(right_Local < -32768)begin
					rightSampleOut = -16'd32768;
				end
				else begin
					rightSampleOut = right_Local[15:0];
				end
			end
		end
	end
endmodule
