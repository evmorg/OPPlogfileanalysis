// version 16.1
include project_paths.do

// Table 1
use "`out_dir'/MCA_sessions_w_tri_active_status_pre", clear

egen tag = tag(pat_epi)
keep if tag
drop tag

tab active_status risk, row column
tab risk active_status, chi2
