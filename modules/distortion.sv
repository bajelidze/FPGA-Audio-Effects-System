module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input threshold
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;
	
	always @(leftSampleIn)begin
		left_Local = leftSampleIn;
		right_Local = rightSampleIn;
//		left_Local = left_Local >> 1;
		right_Local = right_Local * 2;
		
		if(left_Local > 32767)begin	//0.75
			leftSampleOut = 16'd32767;
		end
		else if(left_Local < -32768)begin
			leftSampleOut = -16'd32768;
		end
		else begin
			leftSampleOut = left_Local[15:0];
		end
		
		if(right_Local > 29490)begin
			rightSampleOut = 16'd29490;
		end
		else if(right_Local < -29490)begin
			rightSampleOut = -16'd29490;
		end
		else begin
			if(right_Local > 32767)begin
				rightSampleOut = 16'd32767;
			end
			else if(right_Local < -32768)begin
				rightSampleOut = -16'd32768;
			end
			else begin
				rightSampleOut = right_Local[15:0];
			end
		end
	end
endmodule
