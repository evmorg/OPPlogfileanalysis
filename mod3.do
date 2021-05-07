// version 16.1 
include project_paths.do

use "`tmp_dir'/user_access_log", clear

// Define a local variable to use when comparing time between actions:
// gaps bigger than the "inactive threshold" will be flagged to split long
// sessions.
// One solution is to use the global threshold define in the previous Module.
local threshold $inactivity_threshold
// local threshold 1256

// helpful rows to view changes = 1354, pat_num 1 to 2, 1399 pat_num 2 to 3
sort pat_epi act_date act_type_cat
order act_type_cat, a(act_date)

// flag every login as the beginning of a new user session
// and generate a per-user counter
gen session = 1 if act_type == "Login"
bysort pat_epi (act_date): gen eversession = sum(session)
order eversession, a(act_date)

// Generate time from last action variable. This calculates the amount of time,
// in seconds, from the previous action of the user.
bysort pat_epi eversession: gen double act_tfla = act_date - act_date[_n-1]
replace act_tfla = 0 if act_tfla == .
replace act_tfla = act_tfla / 1000
order act_tfla, a(eversession)
 
// flag gaps bigger than defined threshold
gen splitted_session = 1 if act_tfla > `threshold'
replace session = 1 if act_tfla > `threshold'
replace act_tfla = 0 if act_tfla > `threshold'
// re-enumerate user sessions
bysort pat_epi (act_date) : gen artificial_session_num = sum(session)

// Create new session number id, required later
// to merge with dataset with system-assigned session numbers.
gen se_id = string(pat_epi, "%12.0f") + "-" + string(artificial_session_num ,"%05.0f")
// Flag the session id of session artificially created by splitting long ones.
bysort se_id : replace splitted_session = sum(splitted_session)
replace se_id = se_id + "a" if splitted_session == 1

// Reorder variables and save dataset to disk.
keep pat_num epi_num pat_epi act_date act_type act_type_cat ext_info user_agent session_num se_id act_tfla 
order pat_num epi_num pat_epi act_date act_type act_type_cat ext_info user_agent session_num se_id act_tfla 

sort pat_epi se_id act_date act_type_cat, stable

/* CREATE A PROGRESSIVE SESSION COUNTER PER USER */
bysort pat_epi se_id : gen session = 1 if _n == 1
by pat_epi : gen se_num = sum(session)
drop session

save "`tmp_dir'/tasks_w_sessionids", replace

// drop only the inactivity_threshold macro, but not other macros
capture macro drop inactivity_threshold
