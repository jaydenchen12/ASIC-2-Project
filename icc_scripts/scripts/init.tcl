set search_path "$search_path /mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/db_ccs
../source_files/TI_FPU "
set target_library "saed32rvt_ss0p95v25c.db"
set link_library "* $target_library"

sh rm -rf fpu.mw

start_gui
set techfile "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm/tech/milkyway/saed32nm_1p9m_mw.tf"
set ref_lib "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm/lib/stdcell_rvt/milkyway/saed32nm_rvt_1p9m"
set lib_name "fpu"

set design_data ../dc_synth/output/fpu.ddc
set cell_name "fpu"
import_designs $design_data -format ddc -top $cell_name

set mw_logic0_net VSS
set mw_logic1_net VDDA

set libdir "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm/tech/star_rcxt"
set tlupmax "$libdir/saed32nm_1p9m_Cmax.tluplus"
set tlunom "$libdir/saed32nm_1p9m_nominal.tluplus"
set tlupmin "$libdir/saed32nm_1p9m_Cmin.tluplus"
set tech2itf "$libdir/saed32nm_tf_itf_tluplus.map"
set_tlu_plus_files -max_tluplus $tlunom -tech2itf_map $tech2itf

create_mw_lib $lib_name.mw \
                 -technology $techfile \
                 -mw_reference_library $ref_lib

open_mw_lib $lib_name.mw

read_verilog ../dc_synth/output/fpu.v

uniquify_fp_mw_cel

link

read_sdc ../dc_synth/const/fpu.sdc

save_mw_cel -as fpu_initial
