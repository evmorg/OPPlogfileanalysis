// version 16.1
include project_paths.do

import delimited "`in_dir'/OBGYN_PatientPortalUse_NaleefFareed_Tables3.csv", encoding(utf8) clear

// Rename variables
rename v1 pat_num
rename v2 epi_num
rename v3 myc_stat
rename v4 myc_date
rename v5 myc_method
rename v6 myc_cmt
drop v7-v11

egen pat_epi = concat(pat_num epi_num), p(".")
destring pat_epi, replace
order pat_epi, a(epi_num)
keep if epi_num == 1

// rename v7 act_date
// rename v8 act_type
// rename v9 ext_info
// rename v10 session_num
// rename v11 user_agent

// convert myc_date to SIF date
describe myc_date
gen double myc_time = clock(myc_date, "YMDhms")
format myc_time %tc
drop myc_date
rename myc_time myc_date
sort pat_epi

save "`tmp_dir'/status_history_log", replace

include project_paths.do

import delimited "`in_dir'/OBGYN_PatientPortalUse_NaleefFareed_Tables3.csv", encoding(utf8) clear

// Rename variables
rename v1 pat_num
rename v2 epi_num
rename v7 act_date
rename v8 act_type
rename v9 ext_info
rename v10 session_num
rename v11 user_agent
drop v3-v6
drop if missing(act_date) & missing(act_type) & missing(ext_info) & missing(session_num) & missing(user_agent)

egen pat_epi = concat(pat_num epi_num), p(".")
destring pat_epi, replace
order pat_epi, a(epi_num)
keep if epi_num == 1

// convert act_date to SIF date 
describe act_date
gen double act_time = clock(act_date, "YMDhms")
format act_time %tc
drop act_date
rename act_time act_date 

// Standardize text variables.
replace ext_info = lower(ext_info)
replace act_type = strtrim(act_type)

// change variable formats to improve visualization
format %28s act_type
format %28s ext_info

// Create a categorical variable from act_type
// with the goal to control the order of actions that are recorded
// with the same timestamp and have "Login" always appear first.
encode act_type, generate(act_type_cat)
preserve 
keep if act_type == "Login"
levelsof act_type_cat
local numeric_value_of_login = r(levels)
restore
label list act_type_cat 
label define act_type_cat `numeric_value_of_login' "", modify
replace act_type_cat = 0 if act_type_cat == `numeric_value_of_login'
label define act_type_cat 0 "Login", add
label list act_type_cat 

// Repeat the operation for act_type = "Log In From External System".
preserve
keep if act_type == "Log In From External System"
levelsof act_type_cat
local numeric_value_of_ext_login = r(levels)
restore
label define act_type_cat `numeric_value_of_ext_login' "", modify
replace act_type_cat = -1 if act_type_cat == `numeric_value_of_ext_login'
label define act_type_cat -1 "Log In From External System", add
label list act_type_cat 

sort pat_epi act_date act_type session_num
save "`tmp_dir'/user_access_log", replace
