TOP=tb_top

all:
	verilator --cc --exe --build --trace \
		--top-module $(TOP) \
		$(TOP).cpp \
		tb_top.v shiftin.v shiftout.v \
		suTwosComp.v usTwosComp.v umultiplier.v

run:
	./obj_dir/V$(TOP)

wave:
	gtkwave $(TOP).vcd

clean:
	rm -rf obj_dir *.vcd
