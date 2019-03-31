module echo(
	input [15:0] leftSampleIn,
	input [15:0] rightSampleIn,
	output [15:0] leftSampleOut,
	output [15:0] rightSampleOut,
	input Enable,
	input CLOCK_50 //50 Mhz
	);
	
logic signed [15:0] leftSampleIn_Local;
logic signed [15:0] rightSampleIn_Local;
logic signed [15:0] leftSampleOut_Local;
logic signed [15:0] rightSampleOut_Local;
logic signed [15:0] leftBuffer = 0;
logic signed [15:0] rightBuffer = 0;

logic [31:0] delay = 50000000;
logic [31:0] counter = 0;

assign leftSampleIn_Local = leftSampleIn;
assign rightSampleIn_Local = rightSampleIn;

assign leftSampleOut = leftSampleOut_Local;
assign rightSampleOut = rightSampleOut_Local;

always @(posedge CLOCK_50)begin
	if(counter < delay)begin
		counter <= counter + 1;
	end
end

always @(leftSampleIn, rightSampleIn)begin
	if(counter == delay)begin
		leftSampleOut_Local <= leftSampleIn_Local + (leftBuffer / 2);
		leftBuffer <= leftSampleOut_Local;
		
		rightSampleOut_Local <= rightSampleIn_Local + (rightBuffer / 2);
		rightBuffer <= rightSampleOut_Local;
	end
end

endmodule
