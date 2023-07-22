# base_define
set PRJ_IDR $::env(PRJ_IDR_TEST)
set SPYGLASS_HOME $::env(SPYGLASS_HOME)
set top test

set cur_time [clock format [clock seconds] -format "%Y%m%H%M%S"]
set prj_loc [pwd]
new_project ${top}_${cur_time} -projectwdir "$prj_loc" -force

# read files needed
read_file -type sourcelist "${PRJ_IDR}/${top}.f"
read_file -type sgdc "${PRJ_IDR}/${top}.sgdc"
read_file -type awl "${PRJ_IDR}/${top}_waive.awl"

# lib path
# read_file -type gateslib ""
#spyglass setup
set_option sdc2sgdc yes
set_option enable_precompile_vlog yes
set_option enableSV yes
set_option sort yes
set_option 87 yes
set_option language_mode mixed
set_option designread_disable_flatten yes
set_option sgsyn_clock_gating yes
set_option allow_module_override yes
set_option vlog2001_generate_name yes
set_option handlememory yes
set_option define_cell_sim_depth 11
set_option mthresh 400000
set_option disable_html_report {html}
set_option enable_save_restore yes

set_parameter enable_glitchfreecell_detection yes
set_parameter pt no

current_methodology $SPYGLASS_HOME/GuideWare/latest/block/rtl_handoff
current_goal lint/lint_rtl -top ${top}
# must clarify current_goal then add user-defined rules
source ${PRJ_IDR}/lint_rules.tcl
run_goal

save_project -force "${PRJ_IDR}/${top}_${cur_time}/${top}_${cur_time}.prj"

set csh_comment "#!/bin/csh -f"
set run_gui "\n${SPYGLASS_HOME} -project ${top}_${cur_time}.prj"
set gui_name "run_gui.csh"
set file_id [open $gui_name "w+"]
exec chmod 777 $gui_name
puts $file_id $csh_comment
puts $file_id $run_gui
exec mv $gui_name ${top}_${cur_time}
close $file_id

exit -force


