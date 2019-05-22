#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

touch floorplanning.tcl
chmod 755 floorplanning.tcl
echo "# Floorplanning ICC Script" > floorplanning.tcl
echo "# Auto-generated with Bash" >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo 'create_floorplan \' >> floorplanning.tcl
echo '  -core_utilization '"$FP_CORE_UTILIZATION"' \' >> floorplanning.tcl
echo '  -left_io2core '"$FP_IO2CORE_L"' \' >> floorplanning.tcl
echo '  -bottom_io2core '"$FP_IO2CORE_B"' \' >> floorplanning.tcl
echo '  -right_io2core '"$FP_IO2CORE_R"' \' >> floorplanning.tcl
echo '  -top_io2core '"$FP_IO2CORE_T" >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo "# Create VSS Ring" >> floorplanning.tcl
echo 'create_rectangular_rings -nets {vss} \' >> floorplanning.tcl
echo '  -left_offset '"$FP_OFFSET_VSS"' -left_segment_layer M6 -left_segment_width '\
  "$FP_SEG_WIDTH_VSS"' \' >> floorplanning.tcl
echo '  -extend_ll -extend_lh \' >> floorplanning.tcl
echo '  -right_offset '"$FP_OFFSET_VSS"' -right_segment_layer M6 -right_segment_width '\
  "$FP_SEG_WIDTH_VSS"' \' >> floorplanning.tcl
echo '  -extend_rl -extend_rh \' >> floorplanning.tcl
echo '  -bottom_offset '"$FP_OFFSET_VSS"' -bottom_segment_layer M7 -bottom_segment_width '\
  "$FP_SEG_WIDTH_VSS"' \' >> floorplanning.tcl
echo '  -extend_bl -extend_bh \' >> floorplanning.tcl
echo '  -top_offset '"$FP_OFFSET_VSS"' -top_segment_layer M7 -top_segment_width '\
  "$FP_SEG_WIDTH_VSS"' \' >> floorplanning.tcl
echo '  -extend_tl -extend_th' >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo "# Create VDD Ring" >> floorplanning.tcl
echo 'create_rectangular_rings -nets {vdda} \' >> floorplanning.tcl
echo '  -left_offset '"$FP_OFFSET_VDDA"' -left_segment_layer M6 -left_segment_width '\
  "$FP_SEG_WIDTH_VDDA"' \' >> floorplanning.tcl
echo '  -extend_ll -extend_lh \' >> floorplanning.tcl
echo '  -right_offset '"$FP_OFFSET_VDDA"' -right_segment_layer M6 -right_segment_width '\
  "$FP_SEG_WIDTH_VDDA"' \' >> floorplanning.tcl
echo '  -extend_rl -extend_rh \' >> floorplanning.tcl
echo '  -bottom_offset '"$FP_OFFSET_VDDA"' -bottom_segment_layer M7 -bottom_segment_width '\
  "$FP_SEG_WIDTH_VDDA"' \' >> floorplanning.tcl
echo '  -extend_bl -extend_bh \' >> floorplanning.tcl
echo '  -top_offset '"$FP_OFFSET_VDDA"' -top_segment_layer M7 -top_segment_width '\
  "$FP_SEG_WIDTH_VDDA"' \' >> floorplanning.tcl
echo '  -extend_tl -extend_th' >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo "# Create Power Strap" >> floorplanning.tcl
echo 'create_power_straps -nets { VDDA } -layer M6 -direction vertical -width '\
  "$PWR_STRP_WIDTH" >> floorplanning.tcl
echo 'create_power_straps -nets { VSS } -layer M6 -direction vertical -width '\
  "$PWR_STRP_WIDTH" >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo "# Save the design" >> floorplanning.tcl
echo 'save_mw_cel -as fpu_fp' >> floorplanning.tcl
echo "" >> floorplanning.tcl
echo "exit" >> floorplanning.tcl
