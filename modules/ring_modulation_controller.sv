module ring_modulation_controller(
	input key3,
	input key2,
	input [9:0] SW,
	input CLK,
	output [31:0] frequency,
	output disabled
	);
	
	logic key3State = 1;
	logic key2State = 1;
	logic flag = 0;
	logic [31:0] note = 440;
	logic [31:0] mode = 1;
	
	always @(posedge CLK)begin	
		if(flag == 0)begin
			flag = 1;
			frequency = 3551;
		end
		else begin
			if(SW[7] == 1)begin
				if(key3State == 0 && key3 == 1)begin
					key3State = 1;
				end
				else if(key3State == 1 && key3 == 0)begin			
					if(mode > 0)begin
						mode = mode - 1;
					end
					
					case(mode)
						0 : frequency = 4111;
						1 : frequency = 3551;
						2 : frequency = 3255;
						3 : frequency = 3063;
						4 : frequency = 2367;
						5 : frequency = 1791;
						6 : frequency = 1751;
						7 : frequency = 1591;
					endcase
					
					key3State = 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State = 1;
				end
				else if(key2State == 1 && key2 == 0)begin			
					if(mode < 7)begin
						mode = mode + 1;
					end
					
					case(mode)
						0 : frequency = 4111;
						1 : frequency = 3551;
						2 : frequency = 3255;
						3 : frequency = 3063;
						4 : frequency = 2367;
						5 : frequency = 1791;
						6 : frequency = 1751;
						7 : frequency = 1591;
					endcase
					
					key2State = 0;
				end
			end
			
			if(SW[6] == 0)begin
				disabled = 1;
			end
			else begin
				disabled = 0;
			end
		end
	end
	
endmodule
