module ram(
	output signed [15:0] Q,
	input signed [15:0] D,
	input [15:0] write_address,
	input [15:0] read_address,
	input W_E,
	input CLK
	);
	
	parameter WIDTH = 16;
	parameter DEPTH = 65536;
	
	logic signed [WIDTH-1:0] mem [DEPTH-1:0];
	
	always @(posedge CLK)begin
		if(W_E)begin
			mem[write_address] <= D;
		end
		Q <= mem[read_address];
	end
	
endmodule
