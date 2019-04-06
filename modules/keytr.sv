module keytr(
	input key,
	input key1,
	output ON,
	input clock,
	output KEYON,
	output [9:0] counter
	);

	logic [3:0] sw;
	logic flag, D1, D2;
	logic [15:0] delay;

	always @(negedge clock)begin
		if(flag)begin
			sw <= {key, sw[3:1]};
		end
	end

	assign falling_edge = (sw == 4'b0011) ? 1'b1 : 1'b0;

	always @(posedge clock, negedge key1)begin
		if(!key1)begin
			flag <= 1'b1;
		end
		else if(delay==15'd4096)begin
			flag <= 1'b1;
		end
		else if(falling_edge)begin
			flag <= 1'b0;
		end
	end

	always @(posedge clock)begin
		if(!key)begin
			delay <= delay + 1;
		end
		else begin
		  delay <= 15'd0;
		end
	end

	always@(negedge clock)begin
		D1 <= flag;
		D2 <= D1;
	end

	assign KEYON = (D1 | !D2);

endmodule
