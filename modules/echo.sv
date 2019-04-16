module echo(
	input signed [15:0] leftSampleIn,
	input signed [15:0] rightSampleIn,
	output signed [15:0] sampleOut,
	
	input signed [15:0] Q,
	output signed [15:0] D,
	output [15:0] write_address,
	output [15:0] read_address,
	output W_E,
	input ADCLRCK
	);
	
	logic flag = 0;

	always @(posedge ADCLRCK)begin
		if(flag == 0)begin
			D <= leftSampleIn;
			sampleOut <= leftSampleIn;
			W_E <= 1;
			write_address <= 0;
			read_address <= 0;
			flag <= 1;
		end
		else begin
			write_address <= write_address + 1;
			read_address <= read_address + 1;
			
			sampleOut <= leftSampleIn + (Q >>> 1);
			
			D <= sampleOut;
		end
	end
	
endmodule
