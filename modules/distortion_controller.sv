module distortion_controller(input key3, key2, CLK, output led = 0);

//	logic state = 1;
//
//	always @(posedge CLK)begin
//		if(state == 0 && key3 == 1)begin
//			state <= 1;
//		end
//		else if(state == 1 && key3 == 0)begin
//			led <= ~led;
//			state <= 0;
//		end
//	end

	always @(posedge CLK)begin
		if(key3 == 0) led <= 1;
		else led <= 0;
	end

endmodule
