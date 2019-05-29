#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

PDK_LOCATION='/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib'

MAX_PATHS="100"

VOLTAGE_THRESHOLD="hvt" # Transistor voltage threshold (lvt{fast, HP}, rvt, hvt{slow, LP})
TARGET_CORNER_SPEED="ss" # (slow=ss, fast=ff, typical=tt)
TARGET_CORNER_TEMP="25c" # Temperature in Celcius (125c, 25c, n40c {-40c})

#==============================================================================
# DO NOT MODIFY ANYTHING BELOW THIS LINE
#==============================================================================

# Verilog file location
VERILOG="../syn/output/fpu.v"

# SDC Location
SDC="../syn/const/fpu.sdc"

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

touch pt_pre.tcl
chmod 755 pt_pre.tcl
echo "# PrimeTime Analysis Script" > pt_pre.tcl
echo "# Auto-generated with Bash" >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Define library locations" >> pt_pre.tcl
echo "set link_library $LINK_LIB" >> pt_pre.tcl
echo "set target_library $TARGET_LIB" >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Read in verilog files" >> pt_pre.tcl
echo 'read_verilog '"$VERILOG" >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Set top module name" >> pt_pre.tcl
echo "current_design fpu" >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Read SDC from synthesis" >> pt_pre.tcl
echo "source $SDC" >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Analysis reports" >> pt_pre.tcl
echo "report_timing -from [all_inputs] -max_paths $MAX_PATHS -to [all_registers -data_pins] \
      > reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -from [all_register -clock_pins] -max_paths $MAX_PATHS -to \
      [all_registers -data_pins] >> reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -from [all_registers -clock_pins] -max_paths $MAX_PATHS -to \
      [all_outputs] >> reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -from [all_inputs] -max_paths $MAX_PATHS -to \
      [all_outputs] >> reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -from [all_registers -clock_pins] -max_paths $MAX_PATHS -to \
      [all_registers -data_pins] -delay_type max >> reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -from [all_registers -clock_pins] -max_paths $MAX_PATHS -to \
      [all_registers -data_pins] -delay_type min >> reports/timing.rpt" >> pt_pre.tcl
echo "report_timing -transition_time -capacitance -nets -input_pins -from \
      [all_registers -clock_pins] -to [all_registers -data_pins] > reports/timing.tran.cap.rpt"\
      >> pt_pre.tcl
echo "" >> pt_pre.tcl
echo "## Save outputs" >> pt_pre.tcl
echo "save_session output/fpu.session" >> pt_pre.tcl

echo "exit" >> pt_pre.tcl
