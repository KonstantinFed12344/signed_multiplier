//Verilog HDL for "lab3", "shiftout" "verilog"


module shiftout #(parameter DATA_WIDTH = 16, COUNTER_WIDTH = 5) (Z_parallel, Sx, reset, Clk, Z_out, Fx );
input [DATA_WIDTH-1:0] Z_parallel;
input Sx, reset, Clk;
output Z_out, Fx;
reg Z_out, Fx;
reg [COUNTER_WIDTH-1:0] counter;
reg new_shift_out;

always @(posedge Clk or posedge reset)
	if (reset) begin //non-blocking statements
		Fx = 1'b0;
		Z_out = 1'b0;
		counter = {COUNTER_WIDTH{1'b0}};
		new_shift_out = 1'b0;
	end else if (Sx) begin //blocking statements
		if(new_shift_out ==1'b0) begin //reset counter if new stream of bits
			new_shift_out = 1'b1;
			counter = {COUNTER_WIDTH{1'b0}};
		end
			
		if(counter < DATA_WIDTH) begin
			Z_out = Z_parallel[counter]; //set new bit to next place
			counter = counter + 1; //increment counter
			if(counter == DATA_WIDTH) begin //once DATA_WIDTH bits have passed through, set Fx to high
				Fx = 1'b1;
				new_shift_out = 1'b0;
			end
		end
	end

endmodule
