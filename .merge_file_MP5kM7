###########################################################################
### Extraction
###########################################################################

##Go to Layout Window, Route -> Extract RC, it opens up a new window as shown below, click ok. Alternatively, you can run this script on the ICC shell:

extract_rc  -coupling_cap  -routed_nets_only  -incremental

##write parasitic to a file for delay calculations tools (e.g PrimeTime).
write_parasitics -output ./output/s386_extracted.spef -format SPEF

##Write Standard Delay Format (SDF) back-annotation file
write_sdf ./output/s386_extracted.sdf

##Write out a script in Synopsys Design Constraints format
write_sdc ./output/s386_extracted.sdc

##Write out a hierarchical Verilog file for the current design, extracted from layout
write_verilog ./output/s386_extracted.v

##Save the cel and report timing
report_timing -max_paths 100 -delay max > reports/s386_extracted.setup.rpt
report_timing -max_paths 100 -delay min > reports/s386_extracted.hold.rpt
report_power > reports/s386_power.rpt
save_mw_cel -as s386_extracted

