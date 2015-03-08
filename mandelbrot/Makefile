# Where is the Altera SDK for OpenCL software?
ifeq ($(wildcard $(ALTERAOCLSDKROOT)),)
$(error Set ALTERAOCLSDKROOT to the root directory of the Altera SDK for OpenCL software installation)
endif
ifeq ($(wildcard $(ALTERAOCLSDKROOT)/host/include/CL/opencl.h),)
$(error Set ALTERAOCLSDKROOT to the root directory of the Altera SDK for OpenCL software installation.)
endif

# OpenCL compile and link flags.
AOCL_COMPILE_CONFIG := $(shell aocl compile-config)
AOCL_LINK_CONFIG := $(shell aocl link-config)

OTHER_TARGETS := bin/mandelbrot_kernel.aocx

MK_SRCS := Makefile.altera
include common.mk

run:
	cd bin && \
	LD_LIBRARY_PATH=$(LD_LIBRARY_PATH):../../extlibs/lib ./mandelbrot