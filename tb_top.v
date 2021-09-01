//Verilog HDL for "lab3", "tb_top" "verilog"

module tb_top (X_in, Sx, Y_in, Sy, reset, Clk, Mul, Fx, Fy, Don, Sz, Fz, Z_out);
	//parameters
	parameter TB_TOP_X_WIDTH = 8;
	parameter TB_TOP_X_COUNTER_WIDTH = 4;
	parameter TB_TOP_Y_WIDTH = 8;
	parameter TB_TOP_Y_COUNTER_WIDTH = 4;
	parameter TB_TOP_Z_WIDTH = TB_TOP_X_WIDTH + TB_TOP_Y_WIDTH;
	parameter TB_TOP_Z_COUNTER_WIDTH = 5;

	//inputs, outputs, wires, reg's
	input X_in, Y_in, Sx, Sy, reset, Clk, Sz, Mul;
	output Fx, Fy, Fz, Don, Z_out;
	wire [TB_TOP_X_WIDTH-1:0] X_parallel, X_pos;
	wire [TB_TOP_Y_WIDTH-1:0] Y_parallel, Y_pos;
	wire [TB_TOP_Z_WIDTH-1:0] Z_parallel, Z_pos;
	wire Fx_w, Fy_w, negative_w, Don_w;
	

	// temporary wires to pass tb outputs back into modules
	assign Fx_w = Fx;
	assign Fy_w = Fy;
	assign Don_w = Don;
	assign negative_w = X_parallel[TB_TOP_X_WIDTH-1]^Y_parallel[TB_TOP_Y_WIDTH-1]; // check if output negative

	//X shift in module
	shiftin #(.DATA_WIDTH(TB_TOP_X_WIDTH), .COUNTER_WIDTH(TB_TOP_X_COUNTER_WIDTH)) 
		shiftinx(.X_in(X_in), .Sx(Sx), .reset(reset), .Clk(Clk), .X_parallel(X_parallel), .Fx(Fx));

	//Y shift in module
	shiftin #(.DATA_WIDTH(TB_TOP_Y_WIDTH), .COUNTER_WIDTH(TB_TOP_Y_COUNTER_WIDTH)) 
		shiftiny(.X_in(Y_in), .Sx(Sy), .reset(reset), .Clk(Clk), .X_parallel(Y_parallel), .Fx(Fy));

	//X 2's complement module
	suTwosComp #(.DATA_WIDTH(TB_TOP_X_WIDTH))
		suTwosCompx(.X_parallel(X_parallel), .enable(Fx_w), .reset(reset), .Clk(Clk), .X_pos(X_pos));

	//Y 2's complement module
	suTwosComp #(.DATA_WIDTH(TB_TOP_Y_WIDTH))
		suTwosCompy(.X_parallel(Y_parallel), .enable(Fy_w), .reset(reset), .Clk(Clk), .X_pos(Y_pos));

	//X*Y=Z unsigned multiplier
	umultiplier #(.X_WIDTH(TB_TOP_X_WIDTH), .Y_WIDTH(TB_TOP_Y_WIDTH)) 
		unsignedmultiplier(.X_pos(X_pos), .Y_pos(Y_pos), .Mul(Mul), .reset(reset), .Clk(Clk), .Z_pos(Z_pos), .Done(Don));

	//Z 2's complement module
	usTwosComp #(.DATA_WIDTH(TB_TOP_Z_WIDTH))
		usTwosCompz(.X_parallel(Z_pos), .enable(Don_w), .neg(negative_w), .reset(reset), .Clk(Clk), .X_pos(Z_parallel));

	//Z shift out module
	shiftout #(.DATA_WIDTH(TB_TOP_Z_WIDTH), .COUNTER_WIDTH(TB_TOP_Z_COUNTER_WIDTH))
		shiftoutz(.Z_parallel(Z_parallel), .Sx(Sz), .reset(reset), .Clk(Clk), .Z_out(Z_out), .Fx(Fz));
endmodule
