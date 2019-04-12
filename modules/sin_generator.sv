module sinWaveGenerator(
	input CLK,
	output signed [31:0] sin
	);
	
	logic [31:0] x = 0;
	
	logic CLK_Sin = 0;
	logic [31:0] counter = 0;
	
	always @(posedge CLK)begin
		if(counter < 3551)begin //3551
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
			CLK_Sin <= ~CLK_Sin;
		end
	end
	
	always @(posedge CLK_Sin)begin
		case(x)
			0 : sin <= 0;
			1 : sin <= 6;
			2 : sin <= 11;
			3 : sin <= 15;
			4 : sin <= 16;
			5 : sin <= 15;
			6 : sin <= 11;
			7 : sin <= 6;
			8 : sin <= 0;
			9 : sin <= -6;
			10 : sin <= -11;
			11 : sin <= -15;
			12 : sin <= -16;
			13 : sin <= -15;
			14 : sin <= -11;
			15 : sin <= -6;
		endcase
		
		if(x <= 15)begin
			x <= x + 1;
		end
		else begin
			x <= 1;
			sin <= 0;
		end
	end
endmodule
	