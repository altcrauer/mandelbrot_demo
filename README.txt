#set this env var
export AOCL_BOARD_PACKAGE_ROOT=/path/to/bsp

#build aocx with this command
aoc device/mandelbrot_kernel.cl --board de0_nano_sharedonly_with_spi_tft

#build host code
make -f Makefile.arm
