module serializer(
//	input [31:0] ADCDAT_PAR,
	inout BCLK,
	inout DACLRCK,
	output DACDAT_SER,
	input signed [15:0] leftSample,
	input signed [15:0] rightSample
	);

logic flag = 0;
logic start = 0;
logic start2 = 0;
logic [5:0] i = 31;
logic [5:0] t = 0;
logic [5:0] setupCounter = 0;

always_ff @(negedge BCLK)begin
	if(flag == 0)begin
		if(start2 == 0 && DACLRCK == 1)begin
			start2 = 1;
		end
		
		if(start2 == 1)begin
			if(setupCounter < 46)begin
				setupCounter = setupCounter + 1;
			end
			else begin
				flag = 1;
			end
		end
	end
	else begin
		if(start == 0)begin
			if(t < 16)begin
				t = t + 1;
			end
			else begin
				start = 1;
				t = 0;
			end
		end
		
		if(start == 1)begin
			if(i >= 16)begin
				DACDAT_SER = leftSample[i - 16];
				i = i - 1;
				if(i == 15)begin
					start = 0;
				end
			end
			else if(i < 16)begin
				DACDAT_SER = rightSample[i];
				if(i != 0)begin
					i = i - 1;
				end
				else begin
					start = 0;
					i = 31;
				end
			end
		end
	end
end

endmodule
