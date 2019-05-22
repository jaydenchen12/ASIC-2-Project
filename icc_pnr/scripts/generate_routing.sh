#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

touch routing.tcl
chmod 755 routing.tcl
echo "# Routing ICC Script" > routing.tcl
echo "# Auto-generated with Bash" >> routing.tcl
echo "" >> routing.tcl
echo "# Set routing optimization effort" >> routing.tcl
echo "route_opt -effort $ROUTING_EFFORT" >> routing.tcl
echo "" >> routing.tcl
echo "# Save the cel and report timing" >> routing.tcl
echo "save_mw_cel -as fpu_route" >> routing.tcl
echo "report_placement_utilization > reports/fpu_route_util.rpt" >> routing.tcl
echo "report_qor_snapshot > reports/fpu_route_qor_snapshot.rpt" >> routing.tcl
echo "report_qor > reports/fpu_route_qor.rpt" >> routing.tcl
echo "report_timing -max_paths $MAX_PATHS -delay max > reports/fpu_route.setup.rpt" >> routing.tcl
echo "report_timing -max_paths $MAX_PATHS -delay min > reports/fpu_route.hold.rpt" >> routing.tcl
echo "" >> routing.tcl
echo "exit" >> routing.tcl
