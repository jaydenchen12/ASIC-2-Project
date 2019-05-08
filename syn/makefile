# Define required macros here
SHELL = /bin/bash

generate:
	./generate_script.sh
	[ -d "const" ] || mkdir const
	[ -d "work" ] || mkdir work
	[ -d "reports" ] || mkdir reports
	[ -d "output" ] || mkdir output

compile: fpu.tcl
	dc_shell -f fpu.tcl > test.log && echo "Done!"

clean:
	rm -f fpu.tcl const/* work/* reports/* output/* *.log default.svf


