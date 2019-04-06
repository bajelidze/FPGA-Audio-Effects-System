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
		left_Local <= 0;
		right_Local <= 0;
		left_Local <= (leftSampleIn * 12) / 10;
		right_Local <= rightSampleIn * 2;
		
		if(left_Local > 32'd24576)begin	//0.75
			leftSampleOut <= 16'd24576;
		end
		else if(left_Local < -32'd24576)begin
			leftSampleOut <= -16'd24576;
		end
		else begin
			leftSampleOut <= left_Local[15:0];
		end
		
		if(right_Local > 32'd24576)begin
			rightSampleOut <= 16'd24576;
		end
		else if(right_Local < -32'd24576)begin
			rightSampleOut <= -16'd24576;
		end
		else begin
			rightSampleOut <= right_Local[15:0];
		end
	end
endmodule
