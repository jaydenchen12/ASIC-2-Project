#########################################################################################
# General Makefile for ASIC Design II Project                                           #
# Authored by Matthew D'Angeli                                                          #
#########################################################################################

scripts:
	./generate_scripts.sh

setup:
	[ -d "syn/const" ] || mkdir syn/const
	[ -d "syn/work" ] || mkdir syn/work
	[ -d "syn/reports" ] || mkdir syn/reports
	[ -d "syn/output" ] || mkdir syn/output
	[ -d "pt_pre/reports" ] || mkdir pt_pre/reports
	[ -d "pt_pre/output" ] || mkdir pt_pre/output
	[ -d "icc_pnr/output" ] || mkdir icc_pnr/output

clean:
	rm -Rf syn/*.tcl syn/const/* syn/work/* syn/reports/* syn/output/* syn/*.log syn/*.svf syn/alib-52
	rm -Rf pt_pre/*.tcl pt_pre/*.log pt_pre/reports/* pt_pre/output/*
	rm -Rf icc_pnr/scripts/*.tcl icc_pnr/output/* icc_pnr/*.log icc_pnr/*.txt icc_pnr/*.mw

clean_icc:
	rm -Rf icc_pnr/scripts/*.tcl icc_pnr/output/* icc_pnr/*.log icc_pnr/*.txt icc_pnr/*.mw

synthesize: syn/syn.tcl
	cd syn && dc_shell -f syn.tcl > syn.log && cd ..

analyze_pre: pt_pre/pt_pre.tcl
	cd pt_pre && pt_shell -file pt_pre.tcl > pt_pre.log && cd ..

icc_init_design: icc_pnr/scripts/init_design.tcl
	cd icc_pnr && icc_shell -f scripts/init_design.tcl > init_design.log && cd ..
