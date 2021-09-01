//Verilog HDL for "lab3", "usTwosComp" "verilog"


module usTwosComp #(parameter DATA_WIDTH = 16) (X_parallel, enable, neg, reset, Clk, X_pos );
input [DATA_WIDTH-1:0] X_parallel;
input enable, reset, Clk, neg;
output [DATA_WIDTH-1:0] X_pos;
reg [DATA_WIDTH-1:0] X_pos;

always @(posedge Clk or posedge reset)
	if (reset) begin //non-blocking statements
		X_pos = {DATA_WIDTH{1'b0}};
	end else if (enable) begin 
		if(neg ==1'b1) begin //input needs to be switched to negative
			X_pos = ~X_parallel;
			X_pos = X_pos + 1'b1; //Take 2's complement
		end else begin // input is positive, just echo
			X_pos = X_parallel; //echo input
		end
	end

endmodule
