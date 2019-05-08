module vibrato_controller(
	input key3,
	input key2,
	input [9:0] SW,
	input CLK,
	output disabled,
	output [31:0] frequency
	);
	
	logic key3State = 1;
	logic key2State = 1;
	logic flag = 0;
	
	logic [31:0] freq_Hz = 5;
	
	always @(posedge CLK)begin
		if(flag == 0)begin
			flag = 1;
			frequency = 19531;
		end
		else begin
			if(SW[3:0] == 6)begin	// Frequency of LFO 1-10 Hz, 1 Hz step
				if(key3State == 0 && key3 == 1)begin
					key3State = 1;
				end
				else if(key3State == 1 && key3 == 0)begin
					if(freq_Hz > 1)begin
						freq_Hz = freq_Hz - 1;
						frequency = 97656 / freq_Hz;
					end
					key3State = 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State = 1;
				end
				else if(key2State == 1 && key2 == 0)begin
					if(freq_Hz < 10)begin
						freq_Hz = freq_Hz + 1;
						frequency = 97656 / freq_Hz;
					end
					key2State = 0;
				end
			end
			else if(SW[3:0] == 7)begin	// Max phase shift
				if(key3State == 0 && key3 == 1)begin
					key3State = 1;
				end
				else if(key3State == 1 && key3 == 0)begin
					//here
					key3State = 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State = 1;
				end
				else if(key2State == 1 && key2 == 0)begin
					//here
					key2State = 0;
				end
			end
			
			if(SW[5] == 0)begin
				disabled = 1;
			end
			else begin
				disabled = 0;
			end
		end
	end
	
endmodule
