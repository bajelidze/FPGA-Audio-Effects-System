module deserializer(input ADCDAT, inout BCLK, ADCLRCK, output [31:0] ADCDAT_PAR);
	logic start = 0;
	logic [5:0] i = 31;
	logic [31:0] ADCDAT_PAR_Local;

	always_ff @(posedge BCLK)begin
		if(start == 0 && ADCLRCK == 1)begin
			start = 1;
		end
		if(start == 1)begin
			if(ADCLRCK == 1 && i >= 16)begin
				ADCDAT_PAR_Local[i] = ADCDAT;
				i = i - 1;
			end
			else if(ADCLRCK == 0 && i < 16)begin
				ADCDAT_PAR_Local[i] = ADCDAT;
				if(i != 0)begin
					i = i - 1;
				end
				else begin
					start = 0;
					i = 31;
					ADCDAT_PAR = ADCDAT_PAR_Local;
				end
			end
		end
	end
endmodule
