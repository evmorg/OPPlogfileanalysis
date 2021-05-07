// version 16.1
include project_paths.do

import delimited "`in_dir'/OBGYN_PatientPortalUse_NaleefFareed_Table1.csv", encoding(utf8) clear
save "`tmp_dir'/Table1", replace

use "`out_dir'/MCA_sessions", clear

// Merge session data with demographics
merge m:1 pat_num epi_num using "`tmp_dir'/Table1"
sort pat_epi se_id
drop if _merge == 2
drop _merge

// Calculate total number of sessions for each pap_epi
by pat_epi: egen double se_max = max(se_num)
order se_max, a(se_effective_length)

// Convert dates
gen se_start_mdy = dofc(se_start)
format se_start_mdy %td
order se_start_mdy, a(se_start)

gen est_del_time = date(est_del_date, "MD20Y")
order est_del_time, a(est_del_date)
format est_del_time %td
drop est_del_date
rename est_del_time est_del_date

gen del_time = date(del_date, "MD20Y")
order del_time, a(del_date)
format del_time %td
drop del_date
rename del_time del_date

// Generate trimester start dates
gen tri1_start = est_del_date - 280
gen tri2_start = est_del_date - 182
gen tri3_start = est_del_date - 84

format tri1_start %td
format tri2_start %td
format tri3_start %td

// Generate length of pregnancy episode
gen epi_length = del_date - tri1_start  

// Generate days to estimated delivery date from first session date
gen tt_estdel = est_del_date - se_start_mdy 

// Drop those with more than 280 days between first session and estimated delivery date, as do not want to include those with use outside of possible pregnancy window
drop if tt_estdel > 280
drop if se_start_mdy > del_date & se_start_mdy < est_del_date

// Identify sessions with start dates within trimester window. 
by pat_epi : gen se_tri1 = 1 if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : gen se_tri2 = 1 if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : gen se_tri3 = 1 if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

// Identify pregnancy episodes with start dates within trimester window 
egen active_tri1 = max(se_tri1), by(pat_epi)
egen active_tri2 = max(se_tri2), by(pat_epi)
egen active_tri3 = max(se_tri3), by(pat_epi)

drop se_tri1-se_tri3

// Generate active status, with active defined as at least one session in each trimester
egen active_sum = rowtotal(active_tri1-active_tri3)

gen active_status = 0
by pat_epi : replace active_status = 1 if active_sum == 3 
label define active_statusl 0 "inactive" 1 "active"
label values active_status active_statusl 

save "`out_dir'/MCA_sessions_w_tri_active_status_pre", replace

keep if active_status == 1

save "`out_dir'/MCA_sessions_w_tri_active_status", replace
