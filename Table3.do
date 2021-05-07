// version 16.1
include project_paths.do

// Table 3
use "`out_dir'/MCA_action_function_use", clear

// Sesseion level frequency of use for each portal function
foreach var of varlist GR1_messaging-GR9_custom {
	tab `var' if `var' == 1
	tab `var' risk if `var' == 1
}
// Patient level frequency of use for each portal function
egen tag = tag(pat_epi)
keep if tag
drop tag

tab risk

foreach var of varlist GR1_epi-GR5_epi {
	tabstat `var' if `var' >= 1, stat(count)
	tabstat `var' if `var' >= 1, by(risk) stat(count)
}
foreach var of varlist GR7_epi-GR9_epi {
	tabstat `var' if `var' >= 1, stat(count)
	tabstat `var' if `var' >= 1, by(risk) stat(count)
}
