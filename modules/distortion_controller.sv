module distortion_controller(
	input key3,
	input key2,
	input [9:0] SW,
	input CLK,
	output signed [15:0] gain,
	output signed [31:0] threshold,
	output [1:0] mode
	);

	logic key3State = 1;
	logic key2State = 1;
	logic flag = 0;

	always @(posedge CLK)begin
		if(flag == 0)begin
			gain <= 1;
			flag <= 1;
			mode <= 0;
			threshold <= 1000; //remove this
		end
		else begin
			if(mode == 1)begin
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
			else if(mode == 3)begin
				if(key3State == 0 && key3 == 1)begin
					key3State <= 1;
				end
				else if(key3State == 1 && key3 == 0)begin
					if(threshold > 20)begin
						if(threshold <= 100)begin
							threshold <= threshold - 10;
						end
						else if(threshold <= 500)begin
							threshold <= threshold - 50;
						end
						else if(threshold <= 1000)begin
							threshold <= threshold - 100;
						end
						else begin
							threshold <= threshold - 500;
						end
					end
					key3State <= 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State <= 1;
				end
				else if(key2State == 1 && key2 == 0)begin
					if(threshold < 32000)begin
						if(threshold <= 100 && threshold > 20)begin
							threshold <= threshold + 10;
						end
						else if(threshold <= 500)begin
							threshold <= threshold + 50;
						end
						else if(threshold <= 1000)begin
							threshold <= threshold + 100;
						end
						else begin
							threshold <= threshold + 500;
						end
					end
					key2State <= 0;
				end
			end
			
			if(SW[0] == 1 && SW[1] == 0)begin	//01
				mode <= 1;
			end
			else if(SW[0] == 0 && SW[1] == 1)begin	//if SW9 == 0 && SW8 == 1	10
				mode <= 2;
			end
			else if(SW[0] == 1 && SW[1] == 1)begin
				mode <= 3;
			end
			else begin
				mode <= 0;
			end
		end
	end

endmodule
