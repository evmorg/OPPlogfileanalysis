// version 16.1
include project_paths.do

// Table 2
use "`out_dir'/MCA_action_function_use", clear

tab risk

foreach var of varlist GR1_message_center_f-GR9_miscellanea_f {
	tab `var' if `var' >= 1
	tab `var' risk if `var' >= 1
}
