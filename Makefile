CC := g++

LIB_DIR := lib
INC_DIR := include
BIN_DIR := bin
SRC_DIR := src

OUT_DIR := build

CFLAGS += `pkg-config --cflags opencv4`
LDFLAGS += -ggdb `pkg-config --libs opencv4`


# defines what is the main (everything on src/)
MAIN := $(notdir $(wildcard $(SRC_DIR)/*.cpp))

# defines the name of the executable and where to 
#place them (the source without .cpp and on OUT_DIR)
TARGET_EXE := $(patsubst %.cpp, $(OUT_DIR)/%, $(MAIN))


PROG =  
OBJS = $(PROG).o


# Rules of rules
# Create executables





.PHONY: all clean

.DEFAULT_GOAL: all





all: $(TARGET_EXE)

clean:
	rm -f $(OBJS) $(BIN_DIR)/$(PROG)
