# PrimeTime Analysis Script
# Auto-generated with Bash

## Define library locations
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95vn40c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v125c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95vn40c.db ]
set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db ]

## Read in verilog files
read_verilog ../dc_synth/output/fpu.v

## Set top module name
current_design fpu

## Read SDC from synthesis
source ../dc_synth/const/fpu.sdc

## Analysis reports
report_timing -from [all_inputs] -max_paths 100 -to [all_registers -data_pins]       > reports/timing.rpt
report_timing -from [all_register -clock_pins] -max_paths 100 -to       [all_registers -data_pins] >> reports/timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 100 -to       [all_outputs] >> reports/timing.rpt
report_timing -from [all_inputs] -max_paths 100 -to       [all_outputs] >> reports/timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 100 -to       [all_registers -data_pins] -delay_type max >> reports/timing.rpt
report_timing -from [all_registers -clock_pins] -max_paths 100 -to       [all_registers -data_pins] -delay_type min >> reports/timing.rpt
report_timing -transition_time -capacitance -nets -input_pins -from       [all_registers -clock_pins] -to [all_registers -data_pins] > reports/timing.tran.cap.rpt

## Save outputs
save_session output/fpu.session
exit
