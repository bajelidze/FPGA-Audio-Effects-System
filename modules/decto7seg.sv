module decto7seg(
	input [31:0] num,
	output [6:0] segs
	);
	
	localparam [6:0] zero = 7'b1000000;
	localparam [6:0] one = 7'b1111001;
	localparam [6:0] two = 7'b0100100;
	localparam [6:0] three = 7'b0110000;
	localparam [6:0] four = 7'b0011001;
	localparam [6:0] five = 7'b0010010;
	localparam [6:0] six = 7'b0000010;
	localparam [6:0] seven = 7'b1111000;
	localparam [6:0] eight = 7'b0000000;
	localparam [6:0] nine = 7'b0010000;
	
	localparam [6:0] dash = 7'b0111111;
	
	always @(num)begin
		if(num == 0) segs = zero;
		else if(num == 1) segs = one;
		else if(num == 2) segs = two;
		else if(num == 3) segs = three;
		else if(num == 4) segs = four;
		else if(num == 5) segs = five;
		else if(num == 6) segs = six;
		else if(num == 7) segs = seven;
		else if(num == 8) segs = eight;
		else if(num == 9) segs = nine;
		else segs = dash;
	end
endmodule
