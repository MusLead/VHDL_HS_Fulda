# Makefile for compiling VHDL and running simulations with GHDL and GTKWave

# Directories
SRC_DIR = Design_Source
SIM_DIR = Simulation

# VHDL files
SOURCES = $(wildcard $(SRC_DIR)/*.vhd)
TESTBENCHES = $(wildcard $(SIM_DIR)/*.vhd)

# GHDL flags
GHDL_FLAGS = --std=08 -fsynopsys

# Simulation options
SIM_OPTIONS = --wave=wave.ghw

# Targets
all: compile simulate view

compile:
	@echo "Compiling VHDL sources..."
	ghdl -a $(GHDL_FLAGS) $(SOURCES)
	@echo "Compiling testbenches..."
	ghdl -a $(GHDL_FLAGS) $(TESTBENCHES)

simulate: compile
	@echo "Running simulations..."
	@for tb in $(TESTBENCHES); do \
	    tb_name=$$(basename $$tb .vhd); \
	    ghdl -e $(GHDL_FLAGS) $$tb_name; \
	    ghdl -r $(GHDL_FLAGS) $$tb_name $(SIM_OPTIONS); \
	done

view: simulate
	@echo "Opening waveform in GTKWave..."
	gtkwave wave.ghw &

clean:
	@echo "Cleaning up..."
	rm -f *.o *.cf *.ghw *.vcd

.PHONY: all compile simulate view clean

