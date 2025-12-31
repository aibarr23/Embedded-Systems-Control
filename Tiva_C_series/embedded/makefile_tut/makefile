
CC:=gcc
CXX:=g++



TGT_NAME:=fib
TGT_DIR:=./build
TGT:=$(TGT_DIR)/$(TGT_NAME)

DIRS:=. ./lib1 ./lib2
EXTS:=c cpp

#-----Generate linker map--------
#	-Wl,-Map=output.map
#	-Wl: passes the instruction to the linker
# ---enhanced warnings------
# 	-Wall: Enables most common warnings
# 	-pedantic: Enforces strict ANSI/ISO standards, flagging non-standard extensions
# 	-Wextra
#----optimization levels-----
# 	-O0: No optimization
# 	-O1: Basic optimzation
# 	-O2: Moderate optimization
# 	-O3: Aggressive optimization
# 	-Os: Optimized for size
#	-Ofast: Fastest, potentially non-compliant
#	-Og: Optimize for debugging
#----debugging info-------
#	-g: Generates debugging symbols(variable, line numbers)
#----specific code generation----
#	-fstack-arrays
#
FLAGS:=-Wall -Wextra -O3
FLAGS+=-MMD
dir_guard=mkdir -p "$(@D)"
SRCS:=$(foreach dir, $(DIRS), $(foreach ext, $(EXTS), $(wildcard $(dir)/*.$(ext))))
OBJS:=$(SRCS:%=$(TGT_DIR)/%.o)


#
# %: all files with same
# name with different extension
# $@: target  $<: first dependency
# in the list

ifneq ($(MAKECMDGOALS),clean)
	DEPS:=$(OBJS:.o=.d)
	ifneq ($(strip $(DEPS)),)
		-include $(DEPS)
	endif
endif

$(TGT_DIR)/%.c.o: %.c makefile
	@echo $<
	@$(dir_guard)
	@$(CC) $(FLAGS) -std=c17 -c -o $@ $<

$(TGT_DIR)/%.cpp.o: %.cpp makefile
	@echo $<
	@$(dir_guard)
	@$(CXX) $(FLAGS) -std=c++23 -c -o $@ $<

$(TGT): $(OBJS)
	@echo linking $@
	@$(CXX) $(FLAGS) $^ -o $(TGT)


#
# ^ : look  for all objects
#  in the list OBJS
build: $(TGT)

run: build
	@$(TGT)

all: run

timed: build
	@time $(TGT) >/dev/null

clean:
	rm -rf $(TGT_DIR)

help:
	@echo 'Available targets:'
	@echo ' all 	- build and run'
	@echo ' build	- build executable'
	@echo ' clean 	- remove built files'
	@echo ' help 	- show this message'
	@echo ' run	- run the executable'
	@echo ' timed - run the executable with time stats'

.DEFAULT_GOAL:=help
.PHONY: all build clean help run timed
