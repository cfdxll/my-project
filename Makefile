git_tests:
    cd run
	vivado -mode batch -source ../script/vivado_non_project.tcl -notrace -tclargs -cmd run -ifn ../script/file_list.txt -top top -part xcku040-ffva1156-2-e
	#bash git_batch.sh
	exit 0

