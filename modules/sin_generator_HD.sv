module sin_generator_HD(
	input CLK,
	output [31:0] sin
//	input [31:0] frequency
	);
	
	logic [31:0] x = 0;
	logic CLK_Sin = 0;
	logic [31:0] counter = 0;
	
	always @(posedge CLK)begin	
		if(counter < 19531)begin //3551 19531 = 5Hz
			counter <= counter + 1;
		end
		else begin
			counter <= 0;
			CLK_Sin <= ~CLK_Sin;
		end
	end
	
	always @(posedge CLK_Sin)begin
		case(x)
			0 : sin <= 256;
			1 : sin <= 262;
			2 : sin <= 269;
			3 : sin <= 275;
			4 : sin <= 281;
			5 : sin <= 287;
			6 : sin <= 294;
			7 : sin <= 300;
			8 : sin <= 306;
			9 : sin <= 312;
			10 : sin <= 318;
			11 : sin <= 324;
			12 : sin <= 330;
			13 : sin <= 336;
			14 : sin <= 342;
			15 : sin <= 348;
			16 : sin <= 354;
			17 : sin <= 360;
			18 : sin <= 365;
			19 : sin <= 371;
			20 : sin <= 377;
			21 : sin <= 382;
			22 : sin <= 388;
			23 : sin <= 393;
			24 : sin <= 398;
			25 : sin <= 403;
			26 : sin <= 408;
			27 : sin <= 413;
			28 : sin <= 418;
			29 : sin <= 423;
			30 : sin <= 428;
			31 : sin <= 433;
			32 : sin <= 437;
			33 : sin <= 441;
			34 : sin <= 446;
			35 : sin <= 450;
			36 : sin <= 454;
			37 : sin <= 458;
			38 : sin <= 462;
			39 : sin <= 465;
			40 : sin <= 469;
			41 : sin <= 472;
			42 : sin <= 476;
			43 : sin <= 479;
			44 : sin <= 482;
			45 : sin <= 485;
			46 : sin <= 487;
			47 : sin <= 490;
			48 : sin <= 493;
			49 : sin <= 495;
			50 : sin <= 497;
			51 : sin <= 499;
			52 : sin <= 501;
			53 : sin <= 503;
			54 : sin <= 504;
			55 : sin <= 506;
			56 : sin <= 507;
			57 : sin <= 508;
			58 : sin <= 509;
			59 : sin <= 510;
			60 : sin <= 511;
			61 : sin <= 511;
			62 : sin <= 512;
			63 : sin <= 512;
			64 : sin <= 512;
			65 : sin <= 512;
			66 : sin <= 512;
			67 : sin <= 511;
			68 : sin <= 511;
			69 : sin <= 510;
			70 : sin <= 509;
			71 : sin <= 508;
			72 : sin <= 507;
			73 : sin <= 506;
			74 : sin <= 504;
			75 : sin <= 503;
			76 : sin <= 501;
			77 : sin <= 499;
			78 : sin <= 497;
			79 : sin <= 495;
			80 : sin <= 493;
			81 : sin <= 490;
			82 : sin <= 487;
			83 : sin <= 485;
			84 : sin <= 482;
			85 : sin <= 479;
			86 : sin <= 476;
			87 : sin <= 472;
			88 : sin <= 469;
			89 : sin <= 465;
			90 : sin <= 462;
			91 : sin <= 458;
			92 : sin <= 454;
			93 : sin <= 450;
			94 : sin <= 446;
			95 : sin <= 441;
			96 : sin <= 437;
			97 : sin <= 433;
			98 : sin <= 428;
			99 : sin <= 423;
			100 : sin <= 418;
			101 : sin <= 413;
			102 : sin <= 408;
			103 : sin <= 403;
			104 : sin <= 398;
			105 : sin <= 393;
			106 : sin <= 388;
			107 : sin <= 382;
			108 : sin <= 377;
			109 : sin <= 371;
			110 : sin <= 365;
			111 : sin <= 360;
			112 : sin <= 354;
			113 : sin <= 348;
			114 : sin <= 342;
			115 : sin <= 336;
			116 : sin <= 330;
			117 : sin <= 324;
			118 : sin <= 318;
			119 : sin <= 312;
			120 : sin <= 306;
			121 : sin <= 300;
			122 : sin <= 294;
			123 : sin <= 287;
			124 : sin <= 281;
			125 : sin <= 275;
			126 : sin <= 269;
			127 : sin <= 262;
			128 : sin <= 256;
			129 : sin <= 250;
			130 : sin <= 243;
			131 : sin <= 237;
			132 : sin <= 231;
			133 : sin <= 225;
			134 : sin <= 218;
			135 : sin <= 212;
			136 : sin <= 206;
			137 : sin <= 200;
			138 : sin <= 194;
			139 : sin <= 188;
			140 : sin <= 182;
			141 : sin <= 176;
			142 : sin <= 170;
			143 : sin <= 164;
			144 : sin <= 158;
			145 : sin <= 152;
			146 : sin <= 147;
			147 : sin <= 141;
			148 : sin <= 135;
			149 : sin <= 130;
			150 : sin <= 124;
			151 : sin <= 119;
			152 : sin <= 114;
			153 : sin <= 109;
			154 : sin <= 104;
			155 : sin <= 99;
			156 : sin <= 94;
			157 : sin <= 89;
			158 : sin <= 84;
			159 : sin <= 79;
			160 : sin <= 75;
			161 : sin <= 71;
			162 : sin <= 66;
			163 : sin <= 62;
			164 : sin <= 58;
			165 : sin <= 54;
			166 : sin <= 50;
			167 : sin <= 47;
			168 : sin <= 43;
			169 : sin <= 40;
			170 : sin <= 36;
			171 : sin <= 33;
			172 : sin <= 30;
			173 : sin <= 27;
			174 : sin <= 25;
			175 : sin <= 22;
			176 : sin <= 19;
			177 : sin <= 17;
			178 : sin <= 15;
			179 : sin <= 13;
			180 : sin <= 11;
			181 : sin <= 9;
			182 : sin <= 8;
			183 : sin <= 6;
			184 : sin <= 5;
			185 : sin <= 4;
			186 : sin <= 3;
			187 : sin <= 2;
			188 : sin <= 1;
			189 : sin <= 1;
			190 : sin <= 0;
			191 : sin <= 0;
			192 : sin <= 0;
			193 : sin <= 0;
			194 : sin <= 0;
			195 : sin <= 1;
			196 : sin <= 1;
			197 : sin <= 2;
			198 : sin <= 3;
			199 : sin <= 4;
			200 : sin <= 5;
			201 : sin <= 6;
			202 : sin <= 8;
			203 : sin <= 9;
			204 : sin <= 11;
			205 : sin <= 13;
			206 : sin <= 15;
			207 : sin <= 17;
			208 : sin <= 19;
			209 : sin <= 22;
			210 : sin <= 25;
			211 : sin <= 27;
			212 : sin <= 30;
			213 : sin <= 33;
			214 : sin <= 36;
			215 : sin <= 40;
			216 : sin <= 43;
			217 : sin <= 47;
			218 : sin <= 50;
			219 : sin <= 54;
			220 : sin <= 58;
			221 : sin <= 62;
			222 : sin <= 66;
			223 : sin <= 71;
			224 : sin <= 75;
			225 : sin <= 79;
			226 : sin <= 84;
			227 : sin <= 89;
			228 : sin <= 94;
			229 : sin <= 99;
			230 : sin <= 104;
			231 : sin <= 109;
			232 : sin <= 114;
			233 : sin <= 119;
			234 : sin <= 124;
			235 : sin <= 130;
			236 : sin <= 135;
			237 : sin <= 141;
			238 : sin <= 147;
			239 : sin <= 152;
			240 : sin <= 158;
			241 : sin <= 164;
			242 : sin <= 170;
			243 : sin <= 176;
			244 : sin <= 182;
			245 : sin <= 188;
			246 : sin <= 194;
			247 : sin <= 200;
			248 : sin <= 206;
			249 : sin <= 212;
			250 : sin <= 218;
			251 : sin <= 225;
			252 : sin <= 231;
			253 : sin <= 237;
			254 : sin <= 243;
			255 : sin <= 250;
		endcase
		
		if(x < 256)begin
			x <= x + 1;
		end
		else begin
			x <= 1;
			sin <= 0;
		end
	end
endmodule
