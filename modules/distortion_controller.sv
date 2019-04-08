module distortion_controller(
	input key3,
	input key2,
	input SW9,
	input SW8,
	input CLK,
	output signed [15:0] gainNum,
	output signed [15:0] gainDen,
	output [1:0] mode
	);

	logic key3State = 1;
	logic key2State = 1;
	logic flag = 0;

	always @(posedge CLK)begin
		if(flag == 0)begin
			gainNum <= 1;
			gainDen <= 1;
			flag <= 1;
			mode <= 0;
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
			
			if(SW9 == 1)begin
				mode <= 1;
			end
			else if(SW8 == 1)begin	//if SW9 == 0 && SW8 == 1
				mode <= 2;
			end
			else begin
				mode <= 0;
			end
		end
	end

endmodule
