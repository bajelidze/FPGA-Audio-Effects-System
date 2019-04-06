module distortion_controller(input key3, key2, output led);

	always @(negedge key3)begin
		led = 1'b1;
	end

endmodule
