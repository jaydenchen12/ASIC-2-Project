#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli
touch syn.tcl
chmod 755 syn.tcl
echo "# DC Synthesis Script" > syn.tcl
echo "" >> syn.tcl
echo "## Define path to verilog files and define WORK directory" >> syn.tcl
echo "lappend search_path $OPENSPARC_LOCATION/T1-FPU " \
   "$OPENSPARC_LOCATION/T1-common $OPENSPARC_COMMON_DIRS " \
   "$OPENSPARC_LOCATION/T1-CPU/mul" >> syn.tcl 
echo "define_design_lib WORK -path \"work\"" >> syn.tcl
echo "" >> syn.tcl
echo "## Define library locations" >> syn.tcl
echo "set link_library $LINK_LIB" >> syn.tcl
echo "set target_library $TARGET_LIB" >> syn.tcl
echo "" >> syn.tcl
echo "## Read in verilog files" >> syn.tcl
echo 'analyze -library WORK -format verilog [ list '"$OPENSPARC_VERILOG"'mul64.v ]' >> syn.tcl
echo "" >> syn.tcl
echo "elaborate fpu -architecture verilog -library WORK" >> syn.tcl
echo "" >> syn.tcl
echo "current_design fpu" >> syn.tcl
echo "" >> syn.tcl
echo "link" >> syn.tcl
echo "" >> syn.tcl
echo "## Check if design is consistent" >> syn.tcl
echo "check_design > reports/synth_check_design.rpt" >> syn.tcl
echo "" >> syn.tcl
echo "## Create constraints" >> syn.tcl
echo 'create_clock -period '"$CLK_PERIOD"' [get_ports gclk]' >> syn.tcl
echo 'set_clock_latency -max '"$CLK_LATENCY"' [get_ports gclk]' >> syn.tcl
echo '# set_clock_uncertainty '"$CLK_UNCERTAINTY"' [get_ports gclk]' >> syn.tcl
echo 'set_clock_transition '"$CLK_TRANSITION"' [get_clocks gclk]' >> syn.tcl
echo '# set_input_delay '"$INPUT_DELAY"' [ remove_from_collection [all_inputs] clk ] -clock gclk' >> syn.tcl
echo 'set_output_delay '"$OUTPUT_DELAY"' -max -clock [get_clocks gclk] [all_outputs]' >> syn.tcl
echo "" >> syn.tcl
echo 'set_max_area '"$MAX_AREA" >> syn.tcl
echo 'set_load '"$MAX_LOAD"' [all_outputs]' >> syn.tcl
echo "" >> syn.tcl
echo "## Compilation" >> syn.tcl
if [ $COMPILE_ULTRA = "TRUE" ]; then
   echo "compile_ultra $CU_FLAGS" >> syn.tcl
else
   echo "### (NOTE: Values can be low, medium, or high)" >> syn.tcl
   echo "compile -area_effort $AREA_EFFORT -map_effort $MAP_EFFORT -power_effort $POWER_EFFORT" >> syn.tcl
fi
echo "" >> syn.tcl
echo "## Generate area, cell, QOR, resources, and timing reports" >> syn.tcl
echo 'report_power > reports/synth_power.rpt' >> syn.tcl
echo 'report_area > reports/synth_area_.rpt' >> syn.tcl
echo 'report_cell > reports/synth_cell_.rpt' >> syn.tcl
echo 'report_qor > reports/synth_qor.rpt' >> syn.tcl
echo 'report_resources > reports/synth_resources.rpt' >> syn.tcl
echo 'report_timing -max_paths '"$MAX_PATHS"' > reports/synth_timing.rpt' >> syn.tcl
echo "" >> syn.tcl
echo "## Dump constraints to an SDC file" >> syn.tcl
echo 'write_sdc const/fpu.sdc' >> syn.tcl
echo "" >> syn.tcl
echo "## Dump synthesized database and gate-level-netlist" >> syn.tcl
echo 'write -f ddc -hierarchy -output output/fpu.ddc' >> syn.tcl
echo "write -hierarchy -format verilog -output output/fpu.v" >> syn.tcl
echo "" >> syn.tcl
echo "exit" >> syn.tcl
