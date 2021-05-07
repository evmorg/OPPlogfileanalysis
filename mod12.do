// version 16.1
include project_paths.do

use "`out_dir'/MCA_action_function_use", clear

///// Prepare the post-hoc analysis variables

// se_max per tri and all tri
bysort pat_epi : egen se_max_alltri = count(se_num) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date
bysort pat_epi : egen se_max_tri1 = count(se_num) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
bysort pat_epi : egen se_max_tri2 = count(se_num) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
bysort pat_epi : egen se_max_tri3 = count(se_num) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

egen se_max_alltri_fin = max(se_max_alltri), by(pat_epi)
egen se_max_tri1_fin = max(se_max_tri1), by(pat_epi)
egen se_max_tri2_fin = max(se_max_tri2), by(pat_epi)
egen se_max_tri3_fin = max(se_max_tri3), by(pat_epi)

by pat_epi : replace se_max_alltri_fin = . if se_max_alltri_fin == se_max_alltri_fin[1] & _n > 1
by pat_epi : replace se_max_tri1_fin = . if se_max_tri1_fin == se_max_tri1_fin[1] & _n > 1
by pat_epi : replace se_max_tri2_fin = . if se_max_tri2_fin == se_max_tri2_fin[1] & _n > 1
by pat_epi : replace se_max_tri3_fin = . if se_max_tri3_fin == se_max_tri3_fin[1] & _n > 1

// count_func_pat by tri and all tri
gen GR1_patct = .
gen GR2_patct = .
gen GR3_patct = .
gen GR4_patct = .
gen GR5_patct = .
gen GR6_patct = .
gen GR7_patct = .
gen GR8_patct = .
gen GR9_patct = .
replace GR1_patct = 1 if GR1_epi != 0
replace GR2_patct = 1 if GR2_epi != 0
replace GR3_patct = 1 if GR3_epi != 0
replace GR4_patct = 1 if GR4_epi != 0
replace GR5_patct = 1 if GR5_epi != 0
replace GR6_patct = 1 if GR6_epi != 0
replace GR7_patct = 1 if GR7_epi != 0
replace GR8_patct = 1 if GR8_epi != 0
replace GR9_patct = 1 if GR9_epi != 0
by pat_epi : replace GR1_patct = . if GR1_patct == GR1_patct[1] & _n > 1
by pat_epi : replace GR2_patct = . if GR2_patct == GR2_patct[1] & _n > 1
by pat_epi : replace GR3_patct = . if GR3_patct == GR3_patct[1] & _n > 1
by pat_epi : replace GR4_patct = . if GR4_patct == GR4_patct[1] & _n > 1
by pat_epi : replace GR5_patct = . if GR5_patct == GR5_patct[1] & _n > 1
by pat_epi : replace GR6_patct = . if GR6_patct == GR6_patct[1] & _n > 1
by pat_epi : replace GR7_patct = . if GR7_patct == GR7_patct[1] & _n > 1
by pat_epi : replace GR8_patct = . if GR8_patct == GR8_patct[1] & _n > 1
by pat_epi : replace GR9_patct = . if GR9_patct == GR9_patct[1] & _n > 1

egen count_func_pat_alltri = rowtotal(GR1_patct-GR9_patct) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date
egen count_func_pat_tri1 = rowtotal(GR1_patct-GR9_patct) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
egen count_func_pat_tri2 = rowtotal(GR1_patct-GR9_patct) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
egen count_func_pat_tri3 = rowtotal(GR1_patct-GR9_patct) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

egen count_func_pat_alltri_fin = max(count_func_pat_alltri), by(pat_epi)
egen count_func_pat_tri1_fin = max(count_func_pat_tri1), by(pat_epi)
egen count_func_pat_tri2_fin = max(count_func_pat_tri2), by(pat_epi)
egen count_func_pat_tri3_fin = max(count_func_pat_tri3), by(pat_epi)

by pat_epi : replace count_func_pat_alltri_fin = . if count_func_pat_alltri_fin == count_func_pat_alltri_fin[1] & _n > 1
by pat_epi : replace count_func_pat_tri1_fin = . if count_func_pat_tri1_fin == count_func_pat_tri1_fin[1] & _n > 1
by pat_epi : replace count_func_pat_tri2_fin = . if count_func_pat_tri2_fin == count_func_pat_tri2_fin[1] & _n > 1
by pat_epi : replace count_func_pat_tri3_fin = . if count_func_pat_tri3_fin == count_func_pat_tri3_fin[1] & _n > 1

// Pregnancy episode length
by pat_epi : replace epi_length = . if epi_length == epi_length[1] & _n > 1

// Days from first session to estimated delivery date 
by pat_epi : replace tt_estdel = . if _n > 1

// Days from first session to delivery date
by pat_epi : gen tt_del = del_date - se_start_mdy 
by pat_epi : replace tt_del = . if _n > 1
order tt_del, a(tt_estdel)

// Days to first session of use by tri
by pat_epi : egen se_start_tri1 = min(se_start_mdy) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen se_start_tri2 = min(se_start_mdy) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen se_start_tri3 = min(se_start_mdy) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

format se_start_tri1 %td
format se_start_tri2 %td
format se_start_tri3 %td

egen se_start_tri1_fin = max(se_start_tri1), by(pat_epi)
egen se_start_tri2_fin = max(se_start_tri2), by(pat_epi)
egen se_start_tri3_fin = max(se_start_tri3), by(pat_epi)

by pat_epi : replace se_start_tri1_fin = . if se_start_tri1_fin == se_start_tri1_fin[1] & _n > 1
by pat_epi : replace se_start_tri2_fin = . if se_start_tri2_fin == se_start_tri2_fin[1] & _n > 1
by pat_epi : replace se_start_tri3_fin = . if se_start_tri3_fin == se_start_tri3_fin[1] & _n > 1

format se_start_tri1_fin %td
format se_start_tri2_fin %td
format se_start_tri3_fin %td

gen ttstart_tri1 = se_start_tri1_fin - tri1_start
gen ttstart_tri2 = se_start_tri2_fin - tri2_start
gen ttstart_tri3 = se_start_tri3_fin - tri3_start

// Days to last session of use by tri
by pat_epi : egen se_end_alltri = max(se_start_mdy) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date
by pat_epi : egen se_end_tri1 = max(se_start_mdy) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen se_end_tri2 = max(se_start_mdy) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen se_end_tri3 = max(se_start_mdy) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

format se_end_alltri %td
format se_end_tri1 %td
format se_end_tri2 %td
format se_end_tri3 %td

egen se_end_alltri_fin = max(se_end_tri1), by(pat_epi)
egen se_end_tri1_fin = max(se_end_tri1), by(pat_epi)
egen se_end_tri2_fin = max(se_end_tri2), by(pat_epi)
egen se_end_tri3_fin = max(se_end_tri3), by(pat_epi)

by pat_epi : replace se_end_alltri_fin = . if se_end_alltri_fin == se_end_alltri_fin[1] & _n > 1
by pat_epi : replace se_end_tri1_fin = . if se_end_tri1_fin == se_end_tri1_fin[1] & _n > 1
by pat_epi : replace se_end_tri2_fin = . if se_end_tri2_fin == se_end_tri2_fin[1] & _n > 1
by pat_epi : replace se_end_tri3_fin = . if se_end_tri3_fin == se_end_tri3_fin[1] & _n > 1

format se_end_alltri_fin %td
format se_end_tri1_fin %td
format se_end_tri2_fin %td
format se_end_tri3_fin %td

gen ttend_alltri = se_end_alltri_fin - tri1_start
gen ttend_tri1 = se_end_tri1_fin - tri1_start
gen ttend_tri2 = se_end_tri2_fin - tri2_start
gen ttend_tri3 = se_end_tri3_fin - tri3_start

// Days between first session of each trimester
gen tbfstart_tri1 = se_start_tri2_fin - se_start_tri1_fin
gen tbfstart_tri2 = se_start_tri3_fin - se_start_tri2_fin
gen tbfstart_tri3 = est_del_date - se_start_tri3_fin

// Ethnicity categories 1=Hispanic, 2=non-hispanic, 3=otherunknown
gen eth_cat=.
replace eth_cat = 1 if ethnicity == "CUBAN" | ethnicity == "LATINO/HISPANIC OTHER" | ethnicity == "MEXICAN, MEXICAN-AMER, CHICANO" | ethnicity == "PUERTO RICAN"
replace eth_cat = 2 if ethnicity == "NOT HISPANIC OR LATINO" 
replace eth_cat = 3 if ethnicity ==  "PATIENT NOT AVAILABLE" | ethnicity == "REFUSED TO ANSWER" | ethnicity == "UNKNOWN (TO PATIENT)"

// Race categories 1=White, 2=Black, 3=Hispanic 4=otherunknown
gen race_cat = 0
replace race_cat = 1 if race == "WHITE"
replace race_cat = 2 if race == "AFRICAN AMERICAN/BLK" | race == "AFRICAN OTHER" | race == "SOMALI"
replace race_cat = 3 if race == "PT NOT AVAILABLE" | race == "REFUSED TO ANSWER" | race == "UNKNOWN (TO PATIENT)"
replace race_cat = 4 if race_cat == 0

// Create new race_ethnicity category, 1=non-Hispanic White, 2=non-Hispanic Black, 3=hispanic , 4= other
generate race_ethn_cat = 0
replace race_ethn_cat= 1 if ethnicity == "NOT HISPANIC OR LATINO" &  race == "WHITE"
replace race_ethn_cat= 2 if race == "AFRICAN AMERICAN/BLK" | race == "AFRICAN OTHER" | race == "SOMALI" &  ethnicity == "NOT HISPANIC OR LATINO"
replace race_ethn_cat= 3 if ethnicity == "CUBAN" | ethnicity == "LATINO/HISPANIC OTHER" | ethnicity == "MEXICAN, MEXICAN-AMER, CHICANO" | ethnicity == "PUERTO RICAN"
replace race_ethn_cat= 4 if race_ethn_cat == 0

// Provider visits
gen visits_cnt = mm_cnt + ob_cnt



drop GR*

///// Prepare the proportion variables for cluster
egen tag = tag(pat_epi)
keep if tag
drop tag

merge 1:1 pat_epi using "`out_dir'/MCA_sumuse_pregtri"
drop _merge

foreach var of varlist sum_GR1_tri1-sum_GR9_tri3 {
	keep if !missing(`var')
}

egen sum_allGR_tri1 = rowtotal(sum_GR*_tri1), missing
egen sum_allGR_tri2 = rowtotal(sum_GR*_tri2), missing
egen sum_allGR_tri3 = rowtotal(sum_GR*_tri3), missing
egen sum_allGR_alltri = rowtotal(sum_allGR_tri*), missing

egen sum_GR1 = rowtotal(sum_GR1*), missing
egen sum_GR2 = rowtotal(sum_GR2*), missing
egen sum_GR3 = rowtotal(sum_GR3*), missing
egen sum_GR4 = rowtotal(sum_GR4*), missing
egen sum_GR5 = rowtotal(sum_GR5*), missing
egen sum_GR7 = rowtotal(sum_GR7*), missing
egen sum_GR8 = rowtotal(sum_GR8*), missing
egen sum_GR9 = rowtotal(sum_GR9*), missing

gen prop_GR1_tri1 = sum_GR1_tri1 / sum_allGR_tri1
gen prop_GR1_tri2 = sum_GR1_tri2 / sum_allGR_tri2
gen prop_GR1_tri3 = sum_GR1_tri3 / sum_allGR_tri3

gen prop_GR2_tri1 = sum_GR2_tri1 / sum_allGR_tri1
gen prop_GR2_tri2 = sum_GR2_tri2 / sum_allGR_tri2
gen prop_GR2_tri3 = sum_GR2_tri3 / sum_allGR_tri3

gen prop_GR3_tri1 = sum_GR3_tri1 / sum_allGR_tri1
gen prop_GR3_tri2 = sum_GR3_tri2 / sum_allGR_tri2
gen prop_GR3_tri3 = sum_GR3_tri3 / sum_allGR_tri3

gen prop_GR4_tri1 = sum_GR4_tri1 / sum_allGR_tri1
gen prop_GR4_tri2 = sum_GR4_tri2 / sum_allGR_tri2
gen prop_GR4_tri3 = sum_GR4_tri3 / sum_allGR_tri3

gen prop_GR5_tri1 = sum_GR5_tri1 / sum_allGR_tri1
gen prop_GR5_tri2 = sum_GR5_tri2 / sum_allGR_tri2
gen prop_GR5_tri3 = sum_GR5_tri3 / sum_allGR_tri3

gen prop_GR7_tri1 = sum_GR7_tri1 / sum_allGR_tri1
gen prop_GR7_tri2 = sum_GR7_tri2 / sum_allGR_tri2
gen prop_GR7_tri3 = sum_GR7_tri3 / sum_allGR_tri3

gen prop_GR8_tri1 = sum_GR8_tri1 / sum_allGR_tri1
gen prop_GR8_tri2 = sum_GR8_tri2 / sum_allGR_tri2
gen prop_GR8_tri3 = sum_GR8_tri3 / sum_allGR_tri3

gen prop_GR9_tri1 = sum_GR9_tri1 / sum_allGR_tri1
gen prop_GR9_tri2 = sum_GR9_tri2 / sum_allGR_tri2
gen prop_GR9_tri3 = sum_GR9_tri3 / sum_allGR_tri3

gen prop_messaging = sum_GR1 / sum_allGR_alltri
gen prop_visits = sum_GR2 / sum_allGR_alltri
gen prop_myrecord = sum_GR3 / sum_allGR_alltri
gen prop_medtools = sum_GR4 / sum_allGR_alltri
gen prop_billing = sum_GR5 / sum_allGR_alltri
gen prop_proxy = sum_GR7 / sum_allGR_alltri
gen prop_pref = sum_GR8 / sum_allGR_alltri
gen prop_custom = sum_GR9 / sum_allGR_alltri

global rate_vars prop_messaging prop_visits prop_myrecord prop_medtools prop_billing prop_proxy prop_pref prop_custom
global rate_vars_tri1 prop_GR1_tri1 prop_GR2_tri1 prop_GR3_tri1 prop_GR4_tri1 prop_GR5_tri1 prop_GR7_tri1 prop_GR8_tri1 prop_GR9_tri1
global rate_vars_tri2 prop_GR1_tri2 prop_GR2_tri2 prop_GR3_tri2 prop_GR4_tri2 prop_GR5_tri2 prop_GR7_tri2 prop_GR8_tri2 prop_GR9_tri2
global rate_vars_tri3 prop_GR1_tri3 prop_GR2_tri3 prop_GR3_tri3 prop_GR4_tri3 prop_GR5_tri3 prop_GR7_tri3 prop_GR8_tri3 prop_GR9_tri3

save "`out_dir'/MCA_prep_cluster_posthoc", replace
