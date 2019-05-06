# Define required macros here
SHELL = /bin/bash

clean:
	rm -f fpu.tcl const/* work/* reports/* output/* *.log default.svf

generate:
	./generate_script.sh

compile: fpu.tcl
	dc_shell -f fpu.tcl > test.log && echo "Done!" 
