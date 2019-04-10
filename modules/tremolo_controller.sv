module tremolo_controller(
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
	logic [31:0] divisor;
	
	always @(posedge CLK)begin
		if(flag == 0)begin
			flag = 1;
			frequency = 19531;
			divisor = 2560;
		end
		else if(SW[9] == 1)begin
			if(key3State == 0 && key3 == 1)begin
				key3State = 1;
			end
			else if(key3State == 1 && key3 == 0)begin
				if(divisor > 256)begin
					divisor = divisor - 256;
					frequency = 50000000 / divisor;
				end
				key3State = 0;
			end
			
			if(key2State == 0 && key2 == 1)begin
				key2State = 1;
			end
			else if(key2State == 1 && key2 == 0)begin
				if(divisor < 5120)begin
					divisor = divisor + 256;
					frequency = 50000000 / divisor;
				end
				key2State = 0;
			end
		end
	end
	
endmodule
