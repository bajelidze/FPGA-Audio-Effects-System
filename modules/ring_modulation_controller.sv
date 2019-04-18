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
	
	always @(posedge CLK)begin	
		if(flag == 0)begin
			flag = 1;
			frequency = 3551;
		end
		else begin
			if(SW[3:0] == 3)begin
				if(key3State == 0 && key3 == 1)begin
					key3State = 1;
				end
				else if(key3State == 1 && key3 == 0)begin			
					if(note > 80)begin
						note = (note * 1000) / 1059;
						frequency = 1562500 / note;
					end
					
					key3State = 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State = 1;
				end
				else if(key2State == 1 && key2 == 0)begin			
					if(note < 2000)begin
						note = (note * 1059) / 1000;
						frequency = 1562500 / note;
					end
					
					key2State = 0;
				end
			end
			
			if(SW[7] == 0)begin
				disabled = 1;
			end
			else begin
				disabled = 0;
			end
		end
	end
	
endmodule
