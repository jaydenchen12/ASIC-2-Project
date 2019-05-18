###########################################################################
### Clock Tree Synthesis
###########################################################################

##In the Layout window, click on "Clock ", you will see various options, you can set any of the options to run CTS. If you click on Clock ' Core CTS and Optimization

##Save the Cell and report timing

save_mw_cel -as s386_cts
report_placement_utilization > reports/s386_cts_util.rpt
report_qor_snapshot > reports/s386_cts_qor_snapshot.rpt
report_qor > reports/s386_cts_qor.rpt
report_timing -max_paths 100 -delay max > reports/s386_cts.setup.rpt
report_timing -max_paths 100 -delay min > reports/s386_cts.hold.rpt
report_clock_tree -summary > reports/s386_tree.rpt
report_power > reports/s386_cts_power.rpt
