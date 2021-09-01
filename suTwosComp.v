//Verilog HDL for "lab3", "suTwosComp" "verilog"


module suTwosComp #(parameter DATA_WIDTH = 8) (X_parallel, enable, reset, Clk, X_pos );
input [DATA_WIDTH-1:0] X_parallel;
input enable, reset, Clk;
output [DATA_WIDTH-1:0] X_pos;
reg [DATA_WIDTH-1:0] X_pos;

always @(posedge Clk or posedge reset)
	if (reset) begin //non-blocking statements
		X_pos = {DATA_WIDTH{1'b0}};
	end else if (enable) begin 
		if(X_parallel[DATA_WIDTH-1] == 1'b1) begin //Input is negative number
			X_pos = ~X_parallel;
			X_pos = X_pos + 1'b1; //Take 2's complement
		end else if (X_parallel[DATA_WIDTH-1] == 1'b0) begin //Input is positive number
			X_pos = X_parallel; //echo input
		end
	end

endmodule
