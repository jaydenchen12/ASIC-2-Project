# Define required macros here
SHELL = /bin/bash

clean:
	rm -f pt_pre.tcl reports/* output/* 

generate:
	./generate_script.sh
	[ -d "reports" ] || mkdir reports
	[ -d "output" ] || mkdir output

analyze: pt_pre.tcl
	pt_shell -file pt_pre.tcl > test.log && echo "Done!" 
