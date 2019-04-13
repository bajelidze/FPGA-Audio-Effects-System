module ring_modulation(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	input signed [31:0] sin,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input disabled
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;
	
	always @(leftSampleIn)begin
		if(disabled == 0)begin
			left_Local = leftSampleIn;
			right_Local = rightSampleIn;
			
			left_Local = (left_Local * sin) >>> 4;
			right_Local = (right_Local * sin) >>> 4;
			
			leftSampleOut = left_Local[15:0];
			rightSampleOut = right_Local[15:0];
		end
		else begin
			leftSampleOut = leftSampleIn;
			rightSampleOut = rightSampleIn;
		end
	end
	
endmodule
