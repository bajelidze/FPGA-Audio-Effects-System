module amplitude2leds(
	input signed [15:0] sample,
	output [9:0] leds
	);
	
	logic [31:0] leds_local = 0;
	
	always @(sample)begin
		if(sample > 0)begin
			leds_local <= sample >> 6;
			leds <= leds_local[9:0];
		end
		else begin
			leds_local <= ((~sample) + 1) >> 6;
			leds <= leds_local[9:0];
		end
	end
endmodule
