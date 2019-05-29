# Initial Design ICC Script
# Auto-generated with Bash

## Set up search paths and libraries
set search_path "$search_path /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs ~/ASIC-2_Project/source_files/T1-FPU/"

set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95vn40c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95vn40c.db ]

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/db_ccs/saed32lvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]
#

set techfile "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/tech/milkyway/saed32nm_1p9m_mw.tf"
set ref_lib "/mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_lvt/milkyway/saed32nm_lvt_1p9m"
set lib_name "fpu"
set mw_logic0_net VSS
set mw_logic1_net VDDA
create_mw_lib $lib_name.mw \
   -technology $techfile \
   -mw_reference_library $ref_lib
open_mw_lib $lib_name.mw

set design_data ../dc_synth/output/fpu.ddc
set cell_name "fpu"
import_designs $design_data -format ddc -top $cell_name

set libdir "/tech/star_rcxt"
set tlupmax "$libdir/saed32nm_1p9m_Cmax.tluplus"
set tlunom "$libdir/saed32nm_1p9m_nominal.tluplus"
set tlupmin "$libdir/saed32nm_1p9m_Cmin.tluplus"
set tech2itf "$libdir/saed32nm_tf_itf_tluplus.map"
set_tlu_plus_files -max_tluplus $tlunom -tech2itf_map $tech2itf

read_verilog ../dc_synth/output/fpu.v

uniquify_fp_mw_cel

link

read_sdc ../dc_synth/const/fpu.sdc

save_mw_cel -as fpu_initial

exit

