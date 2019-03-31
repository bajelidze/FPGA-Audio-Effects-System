//module echo(
//	input [15:0] leftSampleIn,
//	input [15:0] rightSampleIn,
//	output [15:0] leftSampleOut,
//	output [15:0] rightSampleOut,
//	input Enable,
//	input CLOCK_50,
//	input ADCLRCK //50 Mhz
//	);
//	
//logic signed [15:0] leftSampleIn_Local;
//logic signed [15:0] rightSampleIn_Local;
//logic signed [15:0] leftSampleOut_Local;
//logic signed [15:0] rightSampleOut_Local;
//logic signed [15:0] leftBuffer = 0;
//logic signed [15:0] rightBuffer = 0;
//
//logic signed [15:0] leftDelayLine [0:47999];
//
//logic [31:0] delay = 47999;
//logic [31:0] counter = 0;
//
//assign leftSampleIn_Local = leftSampleIn;
//assign rightSampleIn_Local = rightSampleIn;
//
//assign leftSampleOut = leftSampleOut_Local;
//assign rightSampleOut = rightSampleOut_Local;
//
////always @(posedge CLOCK_50)begin
////	if(counter < delay)begin
////		counter <= counter + 1;
////	end
////end
//
//always @(posedge ADCLRCK)begin
//	if(counter < delay)begin
//		leftDelayLine[counter] <= leftSampleIn_Local;
//		counter <= counter + 1;
//	end
//	else begin
//		leftDelayLine[0:47998] <= leftDelayLine[1:47999];
//		leftDelayLine[47999] <= leftSampleIn_Local;
//		leftSampleOut_Local <= leftSampleIn_Local + (leftDelayLine[0] / 2);
//	end
//end
//
//endmodule
