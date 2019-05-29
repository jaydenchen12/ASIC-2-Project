setup:
	[ -d "const" ] || mkdir const
	[ -d "work" ] || mkdir work
	[ -d "reports" ] || mkdir reports
	[ -d "output" ] || mkdir output

clean:
	rm -Rf *.tcl *.log *.svf const/* work/* reports/* output/* synthesis

synthesis: syn.tcl
	dc_shell -f $? > $@
