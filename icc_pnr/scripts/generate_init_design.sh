#!/bin/bash
# Generate .tcl script
# 
# Script authored by Matthew D'Angeli

TECHFILE_LOCATION="$PDK_LOCATION"'/tech/milkyway/saed32nm_1p9m_mw.tf'
REFERENCE_LIB="$PDK_LOCATION"'/lib/stdcell_'"$VOLTAGE_THRESHOLD"'/milkyway/saed32nm_'"$VOLTAGE_THRESHOLD"'_1p9m'
LIB_DIR="$PDK_LOCATION"'/tech/star_rcxt'

touch init_design.tcl
chmod 755 init_design.tcl
echo "# Initial Design ICC Script" > init_design.tcl
echo "# Auto-generated with Bash" >> init_design.tcl
echo "" >> init_design.tcl
echo "## Set up search paths and libraries" >> init_design.tcl
echo 'set search_path "$search_path '"$PDK_LOCATION"'/lib/stdcell_'"$VOLTAGE_THRESHOLD"'/db_ccs '"$OPENSPARC_LOCATION"'/T1-FPU '"$OPENSPARC_COMMON_DIRS"'"' >> init_design.tcl
echo 'set target_library "saed32'"$VOLTAGE_THRESHOLD"'_'"$TARGET_CORNER"'.db"'\
   >> init_design.tcl
echo 'set link_library "* $target_library"' >> init_design.tcl
echo "" >> init_design.tcl
echo 'set techfile "'"$TECHFILE_LOCATION"'"' >> init_design.tcl
echo 'set ref_lib "'"$REFERENCE_LIB"'"' >> init_design.tcl
echo 'set lib_name "fpu"' >> init_design.tcl
echo 'set mw_logic0_net VSS' >> init_design.tcl
echo 'set mw_logic1_net VDDA' >> init_design.tcl
echo 'create_mw_lib $lib_name.mw \'>> init_design.tcl
echo '   -technology $techfile \' >> init_design.tcl
echo '   -mw_reference_library $ref_lib' >> init_design.tcl
echo 'open_mw_lib $lib_name.mw' >> init_design.tcl
echo "" >> init_design.tcl
echo 'set design_data ../syn/output/fpu.ddc' >> init_design.tcl
echo 'set cell_name "fpu"' >> init_design.tcl
echo 'import_designs $design_data -format ddc -top $cell_name' >> init_design.tcl
echo "" >> init_design.tcl
echo 'set libdir "'"$LIB_DIR"'"' >> init_design.tcl
echo 'set tlupmax "$libdir/saed32nm_1p9m_Cmax.tluplus"' >> init_design.tcl
echo 'set tlunom "$libdir/saed32nm_1p9m_nominal.tluplus"' >> init_design.tcl
echo 'set tlupmin "$libdir/saed32nm_1p9m_Cmin.tluplus"' >> init_design.tcl
echo 'set tech2itf "$libdir/saed32nm_tf_itf_tluplus.map"' >> init_design.tcl
echo 'set_tlu_plus_files -max_tluplus $tlunom -tech2itf_map $tech2itf' >> init_design.tcl
echo "" >> init_design.tcl
echo 'read_verilog ../syn/output/fpu.v' >> init_design.tcl
echo "" >> init_design.tcl
echo 'uniquify_fp_mw_cel' >> init_design.tcl
echo "" >> init_design.tcl
echo 'link' >> init_design.tcl
echo "" >> init_design.tcl
echo 'read_sdc ../syn/const/fpu.sdc' >> init_design.tcl
echo "" >> init_design.tcl
echo 'save_mw_cel -as fpu_initial' >> init_design.tcl
echo "exit" >> init_design.tcl
