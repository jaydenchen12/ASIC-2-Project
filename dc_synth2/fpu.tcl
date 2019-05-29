# DC Synthesis Script
# Auto-generated with Bash

## Define path to verilog files and define WORK directory
lappend search_path ~/ASIC-2-Project/source_files/T1-FPU/

define_design_lib WORK -path "work"

## Define library locations
set link_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db] 

set target_library [ list /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/stdcell_rvt/db_ccs/saed32rvt_ss0p95v25c.db /mnt/class_data/ecec574-w2019/PDKs/SAED32nm_new/SAED32_EDK/lib/sram/db_ccs/saed32sram_ss0p95v25c.db]

## Read in verilog files
analyze -library WORK -format verilog [ list mul64.v fpu_rptr_macros.v fpu.v fpu_out.v fpu_denorm_3b.v fpu_add_exp_dp.v fpu_cnt_lead0_lvl3.v fpu_mul.v fpu_in.v fpu_div.v fpu_div_exp_dp.v bw_clk_cl_fpu_cmp.v fpu_in2_gt_in1_3b.v fpu_mul_frac_dp.v fpu_rptr_groups.v fpu_in_dp.v fpu_out_dp.v fpu_cnt_lead0_lvl4.v fpu_add_ctl.v fpu_cnt_lead0_53b.v fpu_in2_gt_in1_2b.v fpu_in_ctl.v fpu_rptr_min_global.v fpu_cnt_lead0_64b.v fpu_mul_exp_dp.v fpu_out_ctl.v fpu_div_ctl.v fpu_div_frac_dp.v fpu_in2_gt_in1_3to1.v fpu_in2_gt_in1_frac.v fpu_cnt_lead0_lvl1.v fpu_mul_ctl.v fpu_denorm_frac.v fpu_add_frac_dp.v fpu_denorm_3to1.v fpu_add.v fpu_cnt_lead0_lvl2.v u1.V m1.V swrvr_dlib.v ucb_noflow.v ucb_bus_in.v ucb_flow_2buf.v swrvr_clib.v cluster_header_sync.v cluster_header_dup.v synchronizer_asr_dup.v ucb_bus_out.v test_stub_scan.v sync_pulse_synchronizer.v ucb_flow_jbi.v cluster_header_ctu.v synchronizer_asr.v cluster_header.v cmp_sram_redhdr.v test_stub_bist.v ucb_flow_spi.v dbl_buf.v bw_r_l2d_rep_bot.v bw_r_rf16x128d.v bw_r_l2d_rep_top.v bw_r_rf16x160.v bw_rf_16x65.v bw_r_cm16x40.v bw_r_rf32x80.v regfile_1w_4r.v bw_r_scm.v bw_r_dcm.v bw_r_frf.v bw_r_tlb_fpga.v bw_r_rf16x32.v bw_r_idct.v bw_r_rf32x108.v bw_rf_16x81.v bw_r_l2d.v bw_r_dcd.v bw_r_icd.v bw_r_efa.v bw_r_irf_fpga1.v bw_r_irf.v bw_r_tlb.v bw_r_l2d_32k.v bw_r_irf_register.v bw_r_cm16x40b.v bw_r_l2t.v bw_r_rf32x152b.v ]

elaborate fpu -architecture verilog -library WORK

current_design fpu

link

reset_design
## Check if design is consistent
check_design > reports/synth_check_design.rpt

## Create constraints
create_clock -period 5 [get_ports gclk]
set_clock_latency -max 0.1 [get_ports gclk]
set_clock_uncertainty 0.1 [get_ports gclk]
set_clock_transition 0.1 [get_clocks gclk]
set_input_delay 0.1 [ remove_from_collection [all_inputs] clk ] -clock gclk
set_output_delay 0.1 -max -clock [get_clocks gclk] [all_outputs]

set_max_area 0
set_load 0.3 [all_outputs]

## Compilation
### (NOTE: Values can be low, medium, or high)
remove_attribute fpu max_area
compile_ultra

## Generate area, cell, QOR, resources, and timing reports
report_power > reports/synth_power.rpt
report_area > reports/synth_area_.rpt
report_cell > reports/synth_cell_.rpt
report_qor > reports/synth_qor.rpt
report_resources > reports/synth_resources.rpt
report_timing -max_paths 100 > reports/synth_timing.rpt

## Dump constraints to an SDC file
write_sdc const/fpu.sdc

## Dump synthesized database and gate-level-netlist
write -f ddc -hierarchy -output output/fpu.ddc
write -hierarchy -format verilog -output output/fpu.v

exit
