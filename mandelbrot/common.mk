
ifeq ($(VERBOSE),1)
ECHO := 
else
ECHO := @
endif

# Compilation flags
ifeq ($(DEBUG),1)
CXXFLAGS += -g
else
CXXFLAGS += -O2
endif

# Compiler
CXX := g++

# Target
TARGET := mandelbrot
TARGET_DIR := bin

# Directories
INC_DIRS := . ../extlibs/inc
LIB_DIRS := ../extlibs/lib

# Files
INCS := $(wildcard *.h)
SRCS := $(wildcard *.cpp)
LIBS := SDL2

# Make it all!
all : $(TARGET_DIR)/$(TARGET) $(OTHER_TARGETS)

# Host executable target.
$(TARGET_DIR)/$(TARGET) : common.mk $(MK_SRCS) $(SRCS) $(INCS)
	@[ -d $(TARGET_DIR) ] || mkdir $(TARGET_DIR)
	$(ECHO)$(CXX) $(CPPFLAGS) $(CXXFLAGS) -fPIC $(foreach D,$(INC_DIRS),-I$D) \
			$(AOCL_COMPILE_CONFIG) $(SRCS) $(AOCL_LINK_CONFIG) \
			$(foreach D,$(LIB_DIRS),-L$D) \
			$(foreach L,$(LIBS),-l$L) \
			-o $(TARGET_DIR)/$(TARGET)

# Standard make targets
clean :
	$(ECHO)rm -f $(TARGET_DIR)/$(TARGET)

.PHONY : all clean
