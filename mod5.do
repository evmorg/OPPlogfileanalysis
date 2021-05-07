// version 16.1 
include project_paths.do

use "`tmp_dir'/tasks_w_sessionids_devicetype", clear

sort pat_epi se_id, stable

// calculate start and end time for user sessions
by pat_epi se_id : egen double se_start = min(act_date)
format %tc se_start
by pat_epi se_id : egen double se_end = max(act_date)
format %tc se_end

// calculate duration of user sessions (in sec.)
gen se_length = (se_end - se_start) / 1000
drop se_end
// hist se_length
sum se_length

save "`tmp_dir'/tasks_w_sessionids_devicetype_selen", replace

// repeat the computation without counting "Logouts"
drop if act_type == "Logout"
by pat_epi se_id : egen double se_effective_start = min(act_date)
format %tc se_effective_start
by pat_epi se_id : egen double se_end = max(act_date)
format %tc se_end

// calculate effective time in session (in sec.)
gen se_effective_length = (se_end - se_effective_start) / 1000
drop se_end
// hist se_effective_length
sum se_effective_length
keep pat_num epi_num pat_epi se_id se_effective_start se_effective_length

egen tag = tag(se_id)
keep if tag
drop tag

merge 1:m pat_epi se_id using "`tmp_dir'/tasks_w_sessionids_devicetype_selen"
sort pat_epi se_id act_date
order se_effective_start se_effective_length, a(se_length)
drop _merge

save "`tmp_dir'/tasks_w_sessionids_devicetype_selen", replace
