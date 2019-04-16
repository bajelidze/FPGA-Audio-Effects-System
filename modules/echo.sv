module echo(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] leftSampleOut,
	output signed [15:0] rightSampleOut,
	
	input signed [15:0] Q,
	output signed [15:0] D,
	output [15:0] write_address,
	output [15:0] read_address,
	output W_E,
	input ADCLRCK
	);
	
	logic flag = 0;
	
	logic signed [31:0] sample = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D <= leftSampleIn;
			leftSampleOut <= leftSampleIn;
			rightSampleOut <= rightSampleIn;
			W_E <= 1;
			write_address <= 0;
			read_address <= 0;
			flag <= 1;
		end
		else begin
			write_address <= write_address + 1;
			read_address <= read_address + 1;
			
			sample <= leftSampleIn + (Q >>> 1);
			
			leftSampleOut <= sample[15:0];
			rightSampleOut <= sample[15:0];
			
			D <= sample;
		end
	end
	
endmodule
