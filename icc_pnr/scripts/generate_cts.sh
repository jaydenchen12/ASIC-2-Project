#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

touch cts.tcl
chmod 755 cts.tcl
echo "# Clock Tree Synthesis ICC Script" > cts.tcl
echo "# Auto-generated with Bash" >> cts.tcl
echo "" >> cts.tcl
echo "# Save the cel and report timing" >> cts.tcl
echo "save_mw_cel -as fpu_cts" >> cts.tcl
echo "report_placement_utilization > reports/fpu_cts_util.rpt" >> cts.tcl
echo "report_qor_snapshot > reports/fpu_cts_qor_snapshot.rpt" >> cts.tcl
echo "report_qor > reports/fpu_cts_qor.rpt" >> cts.tcl
echo "report_timing -max_paths $MAX_PATHS -delay max > reports/fpu_cts.setup.rpt" >> cts.tcl
echo "report_timing -max_paths $MAX_PATHS -delay min > reports/fpu_cts.hold.rpt" >> cts.tcl
echo "" >> cts.tcl
echo "exit" >> cts.tcl
