module slapback_controller(
	input key3,
	input key2,
	input [9:0] SW,
	input CLK,
	output [31:0] delay_time,
	output disabled
	);
	
	logic key3State = 1;
	logic key2State = 1;
	logic flag = 0;
	logic [31:0] delay_time_num = 40;
	
	always @(posedge CLK)begin
		if(flag == 0)begin
			flag = 1;
			delay_time = 4800;
		end
		else begin
			if(SW[3:0] == 7)begin
				if(key3State == 0 && key3 == 1)begin
					key3State = 1;
				end
				else if(key3State == 1 && key3 == 0)begin
					if(delay_time_num > 4)begin
						delay_time_num = delay_time_num - 4;
						delay_time = (delay_time_num * 16384) >>> 7;
					end
					key3State = 0;
				end
				
				if(key2State == 0 && key2 == 1)begin
					key2State = 1;
				end
				else if(key2State == 1 && key2 == 0)begin
					if(delay_time_num < 128)begin
						delay_time_num = delay_time_num + 4;
						delay_time = (delay_time_num * 16384) >>> 7;
					end
					key2State = 0;
				end
			end
			
			if(SW[4] == 0)begin
				disabled = 1;
			end
			else begin
				disabled = 0;
			end
		end
	end
	
endmodule
