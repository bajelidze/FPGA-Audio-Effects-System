module volume_controller(
	input [9:0] SW,
	input CLK,
	input key3,
	input key2,
	output signed [31:0] gain
	);
	
	logic flag = 0;
	logic key3State = 1;
	logic key2State = 1;
	
	always @(posedge CLK)begin
		if(flag == 0)begin
			gain <= 1;
			flag <= 1;
		end
		else begin
			if(SW[3:0] == 8)begin
				if(key3State == 0 && key3 == 1)begin
					key3State <= 1;
				end
				else if(key3State == 1 && key3 == 0)begin
					if(gain > 1)begin
						gain <= gain - 1;
					end
					key3State <= 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State <= 1;
				end
				else if(key2State == 1 && key2 == 0)begin
					if(gain < 50)begin
						gain <= gain + 1;
					end
					key2State <= 0;
				end
			end
		end
	end
endmodule
