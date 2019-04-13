module ram(
	output [15:0] Q,
	input [15:0] D,
	input [15:0] write_address,
	input [15:0] read_address,
	input W_E,
	input CLK
	);
	
	logic [15:0] mem [65535:0];
	
	always @(posedge CLK)begin
		if(W_E)begin
			mem[write_address] <= D;
		end
		Q <= mem[read_address];
	end
	
endmodule
