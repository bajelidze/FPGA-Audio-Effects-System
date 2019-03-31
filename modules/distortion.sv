module distortion(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	input ADCLRCK,
	input threshold
	);
	
	always @(leftSampleIn)begin
		if(leftSampleIn > 16'd16384)begin
			leftSampleOut <= 16'd16384;
		end
		else if(leftSampleIn < -16'd16384)begin
			leftSampleOut <= -16'd16384;
		end
		else begin
			leftSampleOut <= leftSampleIn;
		end
		
		if(rightSampleIn > 16'd16384)begin
			rightSampleOut <= 16'd16384;
		end
		else if(rightSampleIn < -16'd16384)begin
			rightSampleOut <= -16'd16384;
		end
		else begin
			rightSampleOut <= rightSampleIn;
		end
	end
endmodule
