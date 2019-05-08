module main_7seg_controller(
	input [9:0] SW,
	
	output [31:0] num0,
	output [31:0] num1,
	output [31:0] num2,
	output [31:0] num3,
	output [31:0] num4,
	output [31:0] num5
	);
	
	always @(SW)begin
		if(SW[3:0] == 5)begin
			num0 <= 3;
			num1 <= 2;
			num2 <= 7;
			num3 <= 6;
			num4 <= 1;
			num5 <= 9;
		end
		else begin
			num0 <= 10;
			num1 <= 10;
			num2 <= 10;
			num3 <= 10;
			num4 <= 10;
			num5 <= 10;
		end
	end
endmodule
