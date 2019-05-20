# ASIC Design II Project
## What is Included
   The top-level project directory contains everything you need to run each component of the ASIC
design process.  Inside each sub-directory are Bash scripts accessed by the `Makefile` to generate
all TCL scripts required for the process.  Data and values required by the generation step are
populated by referencing the `project.config` file automatically.  The user can change these values
as required to generate different builds of the FPU.  The `generate_scripts.sh` Bash script
generates additional parameters to be used by the various steps in script generation, then calls
all subsequent generation scripts within each of the steps.

## The Config File
   The `project.config` file contains adjustable parameters to not only vary the design parameters,
but also point the scripts to where the PDK and OpenSPARC libraries are located.

### Parameters and Brief Descriptions
- `PDK_LOCATION` is where the SAED32nm PDK parent directory is located.  This is the directory
containing the `lib` directory
-  `OPENSPARC_LOCATION` is where the OpenSPARC parent directory is located.  This is the directory 
containing the `T1-FPU` directory
- `VOLTAGE_THRESHOLD` is the voltage threshold of the transistors.  Use `lvt` for a fast, high-
power product, use `rvt` for a typical product, and use `hvt` for a slower, low-power product
- `TARGET_CORNER_SPEED` is exactly what it says.  use `ss` for slow, `ff` for fast, and `tt`, for
typical
- `TARGET_CORNER_TEMP` is the target corner temperature in Celcius.  Options are `125c`, `25c`, 
and `n40c` (-40C)
- `MAX_PATHS` is the maximum number of paths to be used
- `AREA_EFFORT` is a flag for the Design Compiler if using the regular `compile` command.  This
is just an indicator of how much effort you want to emphasize on reduction of area
- `POWER_EFFORT` is similar to above, but for reduction of power consumption
- `MAP_EFFORT` is similar to above, but for routing
- `COMPILE_ULTRA` is a boolean flag for whether to use the `compile_ultra` utility instead of
`compile`
- `CU_FLAGS` are space-delimited flags for the `compile_ultra` utility
- `CLK_PERIOD` is the desired clock period in nanoseconds (we used 200)
- `CLK_LATENCY` is the desired clock latency in nanoseconds (class-standardized to 0.1)
- `CLK_TRANSITION` is the desired clock transition time in nanoseconds (class-standardized to 0.1)
- `CLK_UNCERTAINTY` is the desired clock uncertainty in nanoseconds (class-standardized to 0.1)
- `INPUT_DELAY` is the desired input delay in nanoseconds (class-standardized to 0.1)
- `OUTPUT_DELAY` is the desired output delay in nanoseconds (class-standardized to 0.1)
- `MAX_AREA` is the maximum desired area in square micrometers (0 for "minimize")
- `MAX_LOAD` is a mysterious friend.  Leave him alone.
- `TARGET_CORNER_VOLTAGE` is computed by the config file based on the desired corner
- `TARGET_CORNER` is computed by the config file and is the full corner definition

## The Makefile
   The `Makefile` is the driver of the design process.  It contains the commands to generate the
TCL scripts, run the simulations and compilations, and report relevant values.
### Make commands
   To call the command, simply type `make <command>` into the shell and it will run the described
process
- `scripts` generates all TCL scripts using the `project.config` file
- `setup` sets up the directory structure if pulling directly from Git into an empty directory
- `clean_all` removes all generated TCL, RPT, LOG, SVF, SDC, etc. files from each step in the
process
- `clean_syn` removes all generated files from the synthesis process
- `clean_pt_pre` removes all generated files from the PrimeTime pre-process
- `clean_icc` removes all generated files from the ICC process
- `synthesize` runs the Design Compiler and compiles the design specified according to the 
generated TCL script
- `analyze_pre` runs the PrimeTime analysis on the design specified according to the generated
TCL script
- `icc_init_design` runs the ICC initial design specified according to the generated TCL script
