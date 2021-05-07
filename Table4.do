// version 16.1
include project_paths.do

// Table 4
use "`out_dir'/MCA_action_function_use", clear

// Comprehensiveness of use - session level
egen count_func_se = rowtotal(GR1_messaging-GR9_custom)
tab count_func_se
tab count_func_se risk

// Comprehensiveness of use - patient level 

gen GR1_epict = .
gen GR2_epict = .
gen GR3_epict = .
gen GR4_epict = .
gen GR5_epict = .
gen GR6_epict = .
gen GR7_epict = .
gen GR8_epict = .
gen GR9_epict = .
replace GR1_epict = 1 if GR1_epi != 0
replace GR2_epict = 1 if GR2_epi != 0
replace GR3_epict = 1 if GR3_epi != 0
replace GR4_epict = 1 if GR4_epi != 0
replace GR5_epict = 1 if GR5_epi != 0
replace GR6_epict = 1 if GR6_epi != 0
replace GR7_epict = 1 if GR7_epi != 0
replace GR8_epict = 1 if GR8_epi != 0
replace GR9_epict = 1 if GR9_epi != 0
by pat_epi : replace GR1_epict = . if GR1_epict == GR1_epict[1] & _n > 1
by pat_epi : replace GR2_epict = . if GR2_epict == GR2_epict[1] & _n > 1
by pat_epi : replace GR3_epict = . if GR3_epict == GR3_epict[1] & _n > 1
by pat_epi : replace GR4_epict = . if GR4_epict == GR4_epict[1] & _n > 1
by pat_epi : replace GR5_epict = . if GR5_epict == GR5_epict[1] & _n > 1
by pat_epi : replace GR6_epict = . if GR6_epict == GR6_epict[1] & _n > 1
by pat_epi : replace GR7_epict = . if GR7_epict == GR7_epict[1] & _n > 1
by pat_epi : replace GR8_epict = . if GR8_epict == GR8_epict[1] & _n > 1
by pat_epi : replace GR9_epict = . if GR9_epict == GR9_epict[1] & _n > 1

egen count_func_pat = rowtotal(GR1_epict-GR9_epict)
by pat_epi : replace count_func_pat = . if count_func_pat <= count_func_pat[1] & _n > 1

egen tag = tag(pat_epi)
keep if tag
drop tag

tab risk

tab count_func_pat
tab count_func_pat risk
