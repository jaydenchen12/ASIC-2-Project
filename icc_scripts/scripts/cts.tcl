###########################################################################
### Clock Tree Synthesis
###########################################################################

##In the Layout window, click on "Clock ", you will see various options, you can set any of the options to run CTS. If you click on Clock ' Core CTS and Optimization

##Save the Cell and report timing

save_mw_cel -as fpu_cts
report_placement_utilization > reports/fpu_cts_util.rpt
report_qor_snapshot > reports/fpu_cts_qor_snapshot.rpt
report_qor > reports/fpu_cts_qor.rpt
report_timing -max_paths 100 -delay max > reports/fpu_cts.setup.rpt
report_timing -max_paths 100 -delay min > reports/fpu_cts.hold.rpt
report_clock_tree > reports/clock_tree.rpt

