#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

# Output Verilog file location
OUTPUT_VERILOG="../syn/output/fpu.v"

# Output SDC Location
SDC="../syn/const/fpu.sdc"

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
echo 'read_verilog '"$OUTPUT_VERILOG" >> pt_pre.tcl
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
