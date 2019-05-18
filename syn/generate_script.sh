#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

PDK_LOCATION='/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib'
OPENSPARC_LOCATION='/mnt/class_data/ecec574-w2019/OpenSPARC_src/trunk'

VOLTAGE_THRESHOLD="rvt" # Transistor voltage threshold (lvt{fast, HP}, rvt, hvt{slow, LP})
TARGET_CORNER_SPEED="ss" # (slow=ss, fast=ff, typical=tt)
TARGET_CORNER_TEMP="25c" # Temperature in Celcius (125c, 25c, n40c {-40c})

# Compile Ultra + Settings
COMPILE_ULTRA="TRUE" # TRUE or FALSE; Do you want to use compile_ultra?
CU_PARAMS="-gate_clock" # Paramters for compile_ultra

# Constraints for the CLK
<<<<<<< HEAD
CLK_PERIOD="10" # ns
=======
CLK_PERIOD="1200" # ns
>>>>>>> 6bd86cc6b4b5b62f8f220842150e3298dc634f23
CLK_LATENCY="0.4" # ns
CLK_TRANSITION="0.1" # ns
CLK_UNCERTAINTY="0.05" # ns
INPUT_DELAY="2.0" # ns
OUTPUT_DELAY="2.0" # ns

# Constraints for efforts
MAX_AREA="0"
MAX_LOAD="0.3"

AREA_EFFORT="medium" # (high, medium, low)
POWER_EFFORT="medium" # (high, medium, low)
MAP_EFFORT="medium" # (high, medium, low)

MAX_PATHS="100" # Maximum number of paths

#==============================================================================
# DO NOT MODIFY ANYTHING BELOW THIS LINE
#==============================================================================

# Verilog file location
VERILOG=$(find "$OPENSPARC_LOCATION"/T1-FPU "$OPENSPARC_LOCATION"/T1-common  \
   -iname *.v -printf "%f ")

OPENSPARC_COMMON_FILES=$(find "$OPENSPARC_LOCATION"/T1-common -mindepth 1 \
   -type d -printf "$OPENSPARC_LOCATION/T1-common/%f ")

# Speeds are associated with voltages; these are those voltages
case "$TARGET_CORNER_SPEED" in
  "ss")
    TARGET_CORNER_VOLTAGE="0p95v"
    ;;
  "ff")
    TARGET_CORNER_VOLTAGE="1p16v"
    ;;
  "tt")
    TARGET_CORNER_VOLTAGE="1p05v"
    ;;
  *)
    exit
    ;;
esac

TARGET_CORNER="$TARGET_CORNER_SPEED""$TARGET_CORNER_VOLTAGE""$TARGET_CORNER_TEMP"

CELL_LIB_PREFIX="$PDK_LOCATION"'/stdcell_'"$VOLTAGE_THRESHOLD"'/db_ccs/saed32'"$VOLTAGE_THRESHOLD"
SRAM_PREFIX="$PDK_LOCATION"'/sram/db_ccs/saed32sram'

LINK_LIB_LIST=$(ls -p "$CELL_LIB_PREFIX"_"${TARGET_CORNER%v*}"*.db | tr '\n' ' ')
SRAM_LIB_LIST=$(ls -p "$SRAM_PREFIX"_"${TARGET_CORNER%v*}"*.db | tr '\n' ' ')

LINK_LIB='[ list '"$LINK_LIB_LIST""$SRAM_LIB_LIST"']'
TARGET_LIB='[ list '"$CELL_LIB_PREFIX"'_'"$TARGET_CORNER"'.db '"$SRAM_PREFIX"'_'"$TARGET_CORNER"'.db ]'

touch fpu.tcl
chmod 755 fpu.tcl
echo "# DC Synthesis Script" > fpu.tcl
echo "# Auto-generated with Bash" >> fpu.tcl
echo "" >> fpu.tcl
echo "## Define path to verilog files and define WORK directory" >> fpu.tcl
echo "lappend search_path $OPENSPARC_LOCATION/T1-FPU " \
   "$OPENSPARC_LOCATION/T1-common $OPENSPARC_COMMON_FILES" >> fpu.tcl 
echo "define_design_lib WORK -path \"work\"" >> fpu.tcl
echo "" >> fpu.tcl
echo "## Define library locations" >> fpu.tcl
echo "set link_library $LINK_LIB" >> fpu.tcl
echo "set target_library $TARGET_LIB" >> fpu.tcl
echo "" >> fpu.tcl
echo "## Read in verilog files" >> fpu.tcl
echo 'analyze -library WORK -format verilog [ list '"$VERILOG"']' >> fpu.tcl
echo "" >> fpu.tcl
echo "elaborate fpu -architecture verilog -library WORK" >> fpu.tcl
echo "" >> fpu.tcl
echo "current_design fpu" >> fpu.tcl
echo "" >> fpu.tcl
echo "link" >> fpu.tcl
echo "" >> fpu.tcl
echo "## Check if design is consistent" >> fpu.tcl
echo "check_design > reports/synth_check_design.rpt" >> fpu.tcl
echo "" >> fpu.tcl
echo "## Create constraints" >> fpu.tcl
echo 'create_clock -period '"$CLK_PERIOD"' [get_ports gclk]' >> fpu.tcl
# echo 'set_clock_latency -max '"$CLK_LATENCY"' [get_ports gclk]' >> fpu.tcl
# echo '# set_clock_uncertainty '"$CLK_UNCERTAINTY"' [get_ports gclk]' >> fpu.tcl
# echo 'set_clock_transition '"$CLK_TRANSITION"' [get_clocks gclk]' >> fpu.tcl
# echo '# set_input_delay '"$INPUT_DELAY"' [ remove_from_collection [all_inputs] clk ] -clock gclk' >> fpu.tcl
# echo 'set_output_delay '"$OUTPUT_DELAY"' -max -clock [get_clocks gclk] [all_outputs]' >> fpu.tcl
echo "" >> fpu.tcl
# echo 'set_max_area '"$MAX_AREA" >> fpu.tcl
# echo 'set_load '"$MAX_LOAD"' [all_outputs]' >> fpu.tcl
echo "" >> fpu.tcl
echo "## Compilation" >> fpu.tcl
echo "### (NOTE: Values can be low, medium, or high)" >> fpu.tcl
if [ $COMPILE_ULTRA == "TRUE" ]; then
   echo "compile_ultra $CU_PARAMS" >> fpu.tcl
else
   echo "compile -area_effort $AREA_EFFORT -map_effort $MAP_EFFORT -power_effort $POWER_EFFORT" >> fpu.tcl
fi
echo "" >> fpu.tcl
echo "## Generate area, cell, QOR, resources, and timing reports" >> fpu.tcl
echo 'report_power > reports/synth_power.rpt' >> fpu.tcl
echo 'report_area > reports/synth_area_.rpt' >> fpu.tcl
echo 'report_cell > reports/synth_cell_.rpt' >> fpu.tcl
echo 'report_qor > reports/synth_qor.rpt' >> fpu.tcl
echo 'report_resources > reports/synth_resources.rpt' >> fpu.tcl
echo 'report_timing -max_paths '"$MAX_PATHS"' > reports/synth_timing.rpt' >> fpu.tcl
echo "" >> fpu.tcl
echo "## Dump constraints to an SDC file" >> fpu.tcl
echo 'write_sdc const/fpu.sdc' >> fpu.tcl
echo "" >> fpu.tcl
echo "## Dump synthesized database and gate-level-netlist" >> fpu.tcl
echo 'write -f ddc -hierarchy -output output/fpu.ddc' >> fpu.tcl
echo "write -hierarchy -format verilog -output output/fpu.v" >> fpu.tcl
echo "" >> fpu.tcl
echo "exit" >> fpu.tcl
