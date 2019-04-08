module distortion_controller(input key3, key2, CLK, output signed [15:0] gainNum, output signed [15:0] gainDen);

	logic key3State = 1;
	logic key2State = 1;
	
	logic flag = 0;

	always @(posedge CLK)begin
		if(flag == 0)begin
			gainNum <= 1;
			gainDen <= 1;
			flag <= 1;
		end
		else begin
			if(key3State == 0 && key3 == 1)begin
				key3State <= 1;
			end
			else if(key3State == 1 && key3 == 0)begin
				if(gainNum > 1)begin
					gainNum <= gainNum - 1;
				end
				key3State <= 0;
			end
			
			if(key2State == 0 && key2 == 1)begin
				key2State <= 1;
			end
			else if(key2State == 1 && key2 == 0)begin
				if(gainNum < 50)begin
					gainNum <= gainNum + 1;
				end
				key2State <= 0;
			end
		end
	end

endmodule
