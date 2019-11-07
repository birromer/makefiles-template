CC := g++

LIB_DIR := lib
INC_DIR := include
OBJ_DIR := bin
SRC_DIR := src

INC := -I$(INC_DIR)
LIB := -L$(LIB_DIR)

BUILD_DIR := build

CFLAGS += -ggdb `pkg-config --cflags opencv4`
LDFLAGS += `pkg-config --libs opencv4`


# == Variables of files == 

# defines what is the main (everything on src/)
MAIN := $(wildcard $(SRC_DIR)/*.cpp)

# defines the name of the executable and where to 
#place them (the source without .cpp and on BUILD_DIR)
TARGET_EXE := $(patsubst %.cpp, $(BUILD_DIR)/%, $(notdir $(MAIN)))

# source files that are not executables
SRC := $(filter-out $(MAIN), $(shell find $(SRC_DIR) -name '*.cpp'))

# object files
OBJ := $(patsubst %.cpp, $(OBJ_DIR)/%.o, $(notdir $(SRC)))

# default file fo execute
F ?= main

#default parameter
P ?= ~/Documents/Phi/images/sample.jpeg

# ========================


# == Rules of rules == 

# Create executables
$(TARGET_EXE): $(BUILD_DIR)/%: $(SRC_DIR)/%.cpp $(OBJ)
	$(CC) -o $@ $^ $(INC) $(CFLAGS) $(LIB) $(LDFLAGS) 

# Create objects
$(OBJ_DIR)/%.o:
	$(CC) -c -o $@ $(filter %/$*.cpp, $(SRC)) $(INC) $(CFLAGS) $(LIB) $(LDFLAGS) 


# =====================

.PHONY: all clean

.DEFAULT_GOAL: all


all: $(TARGET_EXE)

run: $(BUILD_DIR)/$(F)
	@./$< $(P)

print-%:
	@echo "$* = $($*)"

clean:
	rm -f $(OBJ_DIR)/*.o $(TARGET_EXE)
