#include <verilated.h>
#include <verilated_vcd_c.h>
#include <bitset>
#include <string>
#include <stdio.h>
#include <cstdio>
#include <cmath>
#include "Vtb_top.h"

static vluint64_t main_time = 0;

std::string int_to_bin(unsigned int value, int length)
{
    std::string s = std::bitset<32>(value).to_string();
    return s.substr(32 - length);
}

int get_most_significant_bit(int value, int length) {
    return (value >> (length - 1)) & 1;
}

int int_to_twos_complement_decimal(int value, int length) {
    int msb = get_most_significant_bit(value, length);
    if (msb) {
        // For negative numbers, calculate the two's complement decimal representation
        return (value - static_cast<int>(pow(2,length)));
    } else {
        return value;
    }
}

double sc_time_stamp() {
    return main_time;
}

static void tick(Vtb_top* dut, VerilatedVcdC* tfp) {
    dut->Clk = 0;
    dut->eval();
    if (tfp) tfp->dump(main_time++);
    
    dut->Clk = 1;
    dut->eval();
    if (tfp) tfp->dump(main_time++);
}

static void delay_cycles(Vtb_top* dut,
                         VerilatedVcdC* tfp,
                         int cycles) {
    for (int i = 0; i < cycles; i++)
        tick(dut, tfp);
}

void reset_dut(Vtb_top* dut, VerilatedVcdC* tfp)
{
    dut->reset = 1;
    delay_cycles(dut, tfp, 2);

    dut->reset = 0;
    delay_cycles(dut, tfp, 1);
}

void run_test(
    Vtb_top* dut,
    VerilatedVcdC* tfp,
    uint8_t x_value,
    uint8_t y_value)
{
    constexpr int X_WIDTH = 8;
    constexpr int Y_WIDTH = 8;

    printf("\n====================================\n");
    printf("X = 0x%02x (decimal: %d, binary: %s) | Y = 0x%02x (decimal: %d, binary: %s)\n",
        x_value, int_to_twos_complement_decimal(x_value, X_WIDTH), int_to_bin(x_value, X_WIDTH).c_str(),
        y_value, int_to_twos_complement_decimal(y_value, Y_WIDTH), int_to_bin(y_value, Y_WIDTH).c_str());
    printf("====================================\n");

    //
    // Shift inputs in MSB first
    //
    for (int ii = 0; ii <= X_WIDTH || ii <= Y_WIDTH; ii++) {

        dut->reset = 0;

        if (ii < X_WIDTH) {
            dut->Sx = 1;
            dut->X_in = (x_value >> (X_WIDTH - ii - 1)) & 1;
        } else if (ii == X_WIDTH) {
            dut->Sx = 0;
        }

        if (ii < Y_WIDTH) {
            dut->Sy = 1;
            dut->Y_in = (y_value >> (Y_WIDTH - ii - 1)) & 1;
        } else if (ii == Y_WIDTH) {
            dut->Sy = 0;
        }

        delay_cycles(dut, tfp, 1);   // equivalent to 1 clk cycle
    }

    delay_cycles(dut, tfp, 2);      // 2 clk cycles

    //
    // Pulse Mul
    //
    delay_cycles(dut, tfp, 1);
    dut->Mul = 1;

    delay_cycles(dut, tfp, 1);
    dut->Mul = 0;

    //
    // Start shifting result out
    //
    delay_cycles(dut, tfp, 1);
    dut->Sz = 1;

    //
    // Wait 100 clk cycles or for Fz to finish
    //
    uint16_t shifted_out = 0;

    for (int i = 0; i < 100; i++) {
        tick(dut, tfp);

        shifted_out <<= 1;
        shifted_out |= (dut->Z_out & 1);

        if (dut->Fz)
            break;
    }

    dut->Sz = 0;

    printf("Shifted result = 0x%04x (decimal: %d, binary: %s)\n",
           shifted_out & 0xffff, int_to_twos_complement_decimal(shifted_out, X_WIDTH + Y_WIDTH), int_to_bin(shifted_out, X_WIDTH + Y_WIDTH).c_str());
	reset_dut(dut, tfp);
}

int main(int argc, char** argv)
{
    Verilated::commandArgs(argc, argv);

    auto dut = new Vtb_top;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    Verilated::traceEverOn(true);

    dut->trace(tfp, 99);
    tfp->open("tb_top.vcd");

    //
    // Initial conditions
    //
    dut->Clk   = 0;
    dut->reset = 1;

    dut->Mul = 0;
    dut->Sx  = 0;
    dut->Sy  = 0;
    dut->Sz  = 0;

    dut->X_in = 0;
    dut->Y_in = 0;

    dut->eval();

    //
    // Test 1: 1 * -1
    //
    run_test(dut, tfp, 0x01, 0xFF);

    //
    // Test 2: -1 * -1
    //
    run_test(dut, tfp, 0xFF, 0xFF);
    //
    // Test 3: 63 * 63
    //
    run_test(dut, tfp, 0x3F, 0x3F);

    //
    // Test 4: -64 * -64
    //
    run_test(dut, tfp, 0xC0, 0xC0);

    //
    // Test 5: -64 * 63
    //
    run_test(dut, tfp, 0xC0, 0x3F);

    //
    // Test 6: 127 * 127
    //
    run_test(dut, tfp, 0x7F, 0x7F);

    //
    // Test 7: -128 * -128
    //
    run_test(dut, tfp, 0x80, 0x80);

    //
    // Test 8: 127 * -128
    //
    run_test(dut, tfp, 0x7F, 0x80);

    //
    // Final reset / finish
    //
    delay_cycles(dut, tfp, 10);  // #100
    dut->reset = 1;

    delay_cycles(dut, tfp, 1);   // #10

    tfp->close();
    delete tfp;
    delete dut;

    return 0;
}
