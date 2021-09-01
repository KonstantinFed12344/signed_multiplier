//Verilog HDL for "lab3", "shiftin" "verilog"


module shiftin #(parameter DATA_WIDTH = 8, COUNTER_WIDTH = 4) (X_in, Sx, reset, Clk, X_parallel, Fx );

input X_in, Sx, reset, Clk;
output [DATA_WIDTH-1:0] X_parallel;
output Fx;
reg [DATA_WIDTH-1:0] X_parallel;
reg Fx;
reg [COUNTER_WIDTH-1:0] counter;
reg new_shift_in;

always @(posedge Clk or posedge reset)
	if (reset) begin //non-blocking statements
		Fx = 1'b0;
		X_parallel = {DATA_WIDTH{1'b0}};
		counter = {COUNTER_WIDTH{1'b0}};
		new_shift_in = 1'b0;
	end else if (Sx) begin //blocking statements
		if(new_shift_in ==1'b0) begin //reset counter if new stream of bits
			new_shift_in = 1'b1;
			counter = {COUNTER_WIDTH{1'b0}};
		end
		if(counter < DATA_WIDTH) begin
			X_parallel = X_parallel <<1; //shift one bit left
			X_parallel[0] = X_in; //replaces shifted spot
			counter = counter + 1; //increment counter
			if(counter == DATA_WIDTH) begin //once DATA_WIDTH bits have passed through, set Fx to high
				Fx = 1'b1;
				new_shift_in = 1'b0;
			end
		end
	end

endmodule
