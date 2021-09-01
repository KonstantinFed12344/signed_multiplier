//Verilog HDL for "lab3", "umultiplier" "verilog"


module umultiplier #(parameter X_WIDTH = 8, Y_WIDTH = 8) (X_pos, Y_pos, Mul, reset, Clk, Z_pos, Done );
localparam Z_WIDTH = X_WIDTH + Y_WIDTH;

input [X_WIDTH-1:0] X_pos;
input [Y_WIDTH-1:0] Y_pos;
input Mul, reset, Clk;
output [Z_WIDTH-1:0] Z_pos;
output Done;
reg [Z_WIDTH-1:0] Z_pos, X_tmp;
reg Done;
integer i;

always @ (posedge reset or posedge Clk)
	if(reset) begin
		Z_pos[Z_WIDTH-1:0] = {Z_WIDTH{1'b0}};
		Done = 1'b0;		
	end else if (Mul) begin
		Done = 1'b0;
		if(X_pos[X_WIDTH-1:0] ==0 || Y_pos[Y_WIDTH-1:0] == 0) begin // if either operand zero, set z_pos to zero
			Z_pos[Z_WIDTH-1:0] = {Z_WIDTH{1'b0}};
			Done = 1'b1;
		end else begin
			Z_pos[Z_WIDTH-1:0] = {Z_WIDTH{1'b0}};
			for(i = 0; i < Y_WIDTH; i=i+1'b1) begin //loop through y_pos bits and perform binary mult
				if(Y_pos[i] == 1'b1) begin
					X_tmp = X_pos;
					X_tmp = X_tmp << i;
					Z_pos = Z_pos + X_tmp;
				end
			end
			Done = 1'b1;
		end
	end

endmodule
