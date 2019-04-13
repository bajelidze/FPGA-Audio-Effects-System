module echo(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	
	input signed [15:0] Q,
	output signed [15:0] D,
	output [15:0] write_address,
	output [15:0] read_address,
	output W_E
	);
	
	logic signed [31:0] left_Local = 0;
	logic signed [31:0] right_Local = 0;
	
	logic flag = 0;
	logic [31:0] counter = 0;

	always @(leftSampleIn)begin
		if(flag == 0)begin
			D <= leftSampleIn;
			leftSampleOut <= leftSampleIn;
			rightSampleOut <= leftSampleIn;
			W_E <= 1;
			write_address <= 0;
			read_address <= 0;
		end
		else begin
			if(counter <= 65535)begin
				counter <= counter + 1;
				
				if(write_address < 65535)
					write_address <= write_address + 1;
				else
					write_address <= 0;
					
				D <= leftSampleIn;
				
				leftSampleOut <= leftSampleIn;
				rightSampleOut <= leftSampleIn;
			end
			else begin
				write_address <= write_address + 1;
				read_address <= read_address + 1;
				
				leftSampleOut <= leftSampleIn + (Q / 2);
				rigthSampleOut <= leftSampleIn + (Q / 2);
				
				D <= leftSampleIn;
			end
		end
	end
	
endmodule
