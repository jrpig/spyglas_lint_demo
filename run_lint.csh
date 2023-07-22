#!/bin/csh -f
#CUR_PATH = $(cd `dirname $0`; pwd)
#echo $CUR_PATH
setenv PRJ_IDR_TEST /home/ICer/ic_prjs/lint_demo
#setenv SPYGLASS_HOME /home/synopsys/SpyGlass-L2016.06/SPYGLASS_HOME/
sg_shell -tcl lint_demo.tcl
