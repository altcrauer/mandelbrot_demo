# OpenCL compile and link flags.
AOCL_COMPILE_CONFIG := -I/altera/opencl_runtime/khronos_headers/CL1.2/
AOCL_LINK_CONFIG = /altera/opencl_runtime/amd_sdk/usr/lib64/libOpenCL.so.1

#OTHER_TARGETS := bin/mandelbrot_kernel.aocx

MK_SRCS := Makefile.altera
include common.mk

run:
	cd bin && \
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):./extlibs/lib ./mandelbrot