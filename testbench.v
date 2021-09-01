
// Verilog stimulus file.
// Please do not create a module in this file.


// Default verilog stimulus. 
parameter TB_TOP_X_WIDTH = 8;
parameter TB_TOP_Y_WIDTH = 8;

reg [TB_TOP_X_WIDTH-1:0] X_value;
reg [TB_TOP_Y_WIDTH-1:0] Y_value;
integer ii;

always begin
        #5 Clk = ~Clk;
end

initial
begin

	Clk = 1'b0; reset = 1'b1; Mul = 1'b0; Sx = 1'b0; Sy = 1'b0; Sz = 1'b0;

	// 1
	// pass in 1*-1
	// x = 1
	X_value = {TB_TOP_X_WIDTH{1'b0}};
	X_value[0] = 1'b1;
	// y = -1
	Y_value = {TB_TOP_Y_WIDTH{1'b1}};

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#10;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 2
	// pass in -1*-1
	// x = -1
	X_value = {TB_TOP_X_WIDTH{1'b1}};
	// y = -1
	Y_value = {TB_TOP_Y_WIDTH{1'b1}};

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 3
	// pass in 63*63
	// x = -1
	X_value = 8'b00111111;
	// y = -1
	Y_value = 8'b00111111;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 4
	// pass in -64*-64
	// x = -1
	X_value = 8'b11000000;
	// y = -1
	Y_value = 8'b11000000;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 5
	// pass in -64*63
	// x = -1
	X_value = 8'b11000000;
	// y = -1
	Y_value = 8'b00111111;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 6
	// pass in 127*127
	// x = 127
	X_value = 8'b01111111;
	// y = 127
	Y_value = 8'b01111111;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 7
	// pass in -128*-128
	// x = -128
	X_value = 8'b10000000;
	// y = -128
	Y_value = 8'b10000000;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

	// 8
	// pass in 127*-128
	// x = 127
	X_value = 8'b01111111;
	// y = -128
	Y_value = 8'b10000000;

	for(ii = 0; ii <= TB_TOP_X_WIDTH || ii <= TB_TOP_Y_WIDTH; ii = ii + 1) begin
		#10 reset = 1'b0;
		if(ii< TB_TOP_X_WIDTH) begin
			Sx = 1'b1;
			X_in = X_value[TB_TOP_X_WIDTH-ii-1];
                end else if(ii ==TB_TOP_X_WIDTH) begin
			Sx = 1'b0;
		end

		if(ii< TB_TOP_Y_WIDTH) begin
			Sy = 1'b1;
			Y_in = Y_value[TB_TOP_Y_WIDTH-ii-1];
                end else if(ii ==TB_TOP_Y_WIDTH) begin
			Sy = 1'b0;
		end
	end
	#20;
	#10 Mul = 1'b1;
	#10 Mul = 1'b0;
	#10 Sz = 1'b1;
	#200 Sz = 1'b0;

        #100 reset = 1'b1;
        #10 $finish;
end

