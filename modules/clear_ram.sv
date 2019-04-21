//module clear_ram(
//	input start,
//	input CLK,
//	output [15:0] D,
//	output [15:0] write_address,
//	output W_E,
//	output done
//	);
//	
//	logic flag = 0;
//	
//	always @(posedge CLK)begin
//		if(flag == 0)begin
//			done <= 0;
//			W_E <= 1;
//			write_address <= 0;
//			D <= 0;
//		end
//		else begin
//			if(start == 1)begin
//				if(write_address <= 480)begin
//					write_address <= write_address + 1;
//					D <= 0;
//				end
//				else begin
//					write_address <= 0;
//					done <= 1;
//				end
//			end
//		end
//	end
//	
//endmodule
