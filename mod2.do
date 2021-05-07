// version 16.1
include project_paths.do

use "`tmp_dir'/user_access_log", clear
// preserve
drop if missing(session_num)

// Calculate time from last action (tfla, in seconds)
sort pat_epi session_num act_date act_type_cat
by pat_epi session_num : gen double tfla = (act_date - act_date[_n-1])/1000
// hist tfla
sum tfla, detail
// graph export "`fig_dir'/hist_tfla.pdf", as(pdf) name("Graph") replace
gen log10tfla = log10(tfla)
// hist log10tfla
sum log10tfla, detail
// graph export "`fig_dir'/hist_logtfla.pdf", as(pdf) name("Graph") replace
// graph twoway kdensity log10tfla
// graph export "`fig_dir'/kdens_logtfla.pdf", as(pdf) name("Graph") replace

// Remove the "second" mode.
drop if act_type == "Logout"
// graph twoway kdensity log10tfla
// graph export "`fig_dir'/kdens_logtfla_drop_logout.pdf", as(pdf) name("Graph") replace
// graph twoway kdensity log10tfla if log10tfla > 1, xline(2.883093)
// graph export "`fig_dir'/kdens_logtfla_drop_logout2.pdf", as(pdf) name("Graph") replace

// quietly perform centile but suppress centil output
centile log10tfla if log10tfla > 1, centile(99)
global inactivity_threshold = 10^r(c_1)
// restore
