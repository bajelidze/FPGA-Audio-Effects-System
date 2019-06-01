module volume(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input signed [31:0] gain
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;
	
	always @(leftSampleIn)begin
		left_Local = leftSampleIn;
		right_Local = rightSampleIn;
		
		left_Local = left_Local * gain;
		right_Local = right_Local * gain;
		
		leftSampleOut = left_Local[15:0];
		rightSampleOut = right_Local[15:0];
	end
endmodule
