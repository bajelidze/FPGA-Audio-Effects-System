module deserializer(input ADCDAT, BCLK, ADCLRCK, output reg [31:0] ADCDAT_PAR);
	reg start = 0;
	reg [5:0] i = 31;

	always @(posedge BCLK)begin
		if(start == 0 && ADCLRCK == 1)begin
			start = 1;
		end
		if(start == 1)begin
			if(ADCLRCK == 1 && i >= 16)begin
				ADCDAT_PAR[i] = ADCDAT;
				i = i - 1;
			end
			else if(ADCLRCK == 0 && i < 16)begin
				ADCDAT_PAR[i] = ADCDAT;
				if(i != 0)begin
					i = i - 1;
				end
				else begin
					start = 0;
					i = 31;
				end
			end
		end
	end
endmodule
