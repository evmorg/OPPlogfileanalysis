// version 16.1 
include project_paths.do

use "`tmp_dir'/tasks_w_sessionids", clear

// MOBILE USER AGENT INFO IS ONLY ASSOCIATED WITH LOGINS.
// DISCARD ALL THE REST.
keep if act_type == "Login"

keep pat_num epi_num pat_epi se_id act_date act_type ext_info user_agent

// REMOVE DUPLICATES.
// method 1 
// unab vlist : _all
// sort `vlist'
// quietly by `vlist':  gen dup = cond(_N==1,0,_n)
// method 2
sort se_id act_date act_type ext_info
quietly by se_id act_date act_type ext_info:  gen dup = cond(_N==1,0,_n)
drop if dup > 1
drop dup

// COMPUTE SESSION TYPE (MOBILE/DESKTOP) AS CATEGORICAL VARIABLE.
gen mobile_info = 0
replace mobile_info = 1 if ext_info == ""
gen mobile_agent = 1
replace mobile_agent = 0 if user_agent == ""
gen se_device = mobile_agent & mobile_info 
drop mobile_info mobile_agent

label define device 1 "mobile" 0 "desktop"
label values se_device device

// CHECK FOR PROBLEMS WITH DUPLICATES
sort se_id 
quietly by se_id : gen dup = cond(_N==1, 0, _n)
drop if dup > 1
keep pat_num epi_num pat_epi se_id se_device

save "`tmp_dir'/session_device_type", replace

// Assign device type to sessions created from long tails in the previous module.
// Use the value from the original, preceeding session.
merge 1:m pat_epi se_id using "/Users/evan/Desktop/Thesis/Data_Temp/tasks_w_sessionids.dta"
drop _merge
sort pat_epi se_id act_date act_type_cat
by pat_epi : replace se_device = se_device[_n - 1] if strmatch(se_id, "*a") & missing(se_device)

save "`tmp_dir'/tasks_w_sessionids_devicetype", replace
