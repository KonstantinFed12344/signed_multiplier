# signed_multiplier
Signed multiplier made in Verilog using two's complement modules and an unsigned multiplier. Input is shifted in serially, and output is shifted out serially. Includes both a verilog stimulus file & a Verilator testbench.

![image](https://user-images.githubusercontent.com/32627734/131609124-baeb4041-710c-406e-9059-b62c6d66a101.png)

# Building
Run `make` in the cmd line to start the build. 
The full build cmd: `verilator --cc --exe --build --trace --top-module tb_top tb_top.cpp tb_top.v shiftin.v shiftout.v suTwosComp.v usTwosComp.v umultiplier.v`.

# Running
Run `make run` to simulate the module with the Verilator testbench. Expected output:
```
====================================
X = 0x01 (decimal: 1, binary: 00000001) | Y = 0xff (decimal: -1, binary: 11111111)
====================================
Shifted result = 0xffff (decimal: -1, binary: 1111111111111111)

====================================
X = 0xff (decimal: -1, binary: 11111111) | Y = 0xff (decimal: -1, binary: 11111111)
====================================
Shifted result = 0x0001 (decimal: 1, binary: 0000000000000001)

====================================
X = 0x3f (decimal: 63, binary: 00111111) | Y = 0x3f (decimal: 63, binary: 00111111)
====================================
Shifted result = 0x0f81 (decimal: 3969, binary: 0000111110000001)

====================================
X = 0xc0 (decimal: -64, binary: 11000000) | Y = 0xc0 (decimal: -64, binary: 11000000)
====================================
Shifted result = 0x1000 (decimal: 4096, binary: 0001000000000000)

====================================
X = 0xc0 (decimal: -64, binary: 11000000) | Y = 0x3f (decimal: 63, binary: 00111111)
====================================
Shifted result = 0xf040 (decimal: -4032, binary: 1111000001000000)

====================================
X = 0x7f (decimal: 127, binary: 01111111) | Y = 0x7f (decimal: 127, binary: 01111111)
====================================
Shifted result = 0x3f01 (decimal: 16129, binary: 0011111100000001)

====================================
X = 0x80 (decimal: -128, binary: 10000000) | Y = 0x80 (decimal: -128, binary: 10000000)
====================================
Shifted result = 0x4000 (decimal: 16384, binary: 0100000000000000)

====================================
X = 0x7f (decimal: 127, binary: 01111111) | Y = 0x80 (decimal: -128, binary: 10000000)
====================================
Shifted result = 0xc080 (decimal: -16256, binary: 1100000010000000)
```
# Waveforms
Run `make wave` to startup an instance of gtkwave with the testbench after running

<img width="1061" height="496" alt="Screenshot 2026-06-14 133506" src="https://github.com/user-attachments/assets/ff244e43-120e-4608-84b8-6c0ee8975e50" />

