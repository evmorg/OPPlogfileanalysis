// version 16.1
include project_paths.do

use "`out_dir'/MCA_action_function_use", clear

drop GR1_message_center_f-GR9_miscellanea_f
drop GR1_epi-GR9_miscellanea_epi

///// For each patient, get the sum of function use in each trimester. This will populate one sum value, which is repeated across every session in that trimester. Somewhat similar to mod9 but GR*_epi but now use is summed per trimester
by pat_epi : egen GR1_tri1 = sum(GR1_messaging) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR1_tri2 = sum(GR1_messaging) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR1_tri3 = sum(GR1_messaging) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR2
by pat_epi : egen GR2_tri1 = sum(GR2_visits) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR2_tri2 = sum(GR2_visits) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR2_tri3 = sum(GR2_visits) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR3
by pat_epi : egen GR3_tri1 = sum(GR3_myrecord) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR3_tri2 = sum(GR3_myrecord) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR3_tri3 = sum(GR3_myrecord) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR4
by pat_epi : egen GR4_tri1 = sum(GR4_medicaltools) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR4_tri2 = sum(GR4_medicaltools) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR4_tri3 = sum(GR4_medicaltools) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR5
by pat_epi : egen GR5_tri1 = sum(GR5_billing) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR5_tri2 = sum(GR5_billing) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR5_tri3 = sum(GR5_billing) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR6
by pat_epi : egen GR6_tri1 = sum(GR6_resources) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR6_tri2 = sum(GR6_resources) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR6_tri3 = sum(GR6_resources) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR7
by pat_epi : egen GR7_tri1 = sum(GR7_proxy) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR7_tri2 = sum(GR7_proxy) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR7_tri3 = sum(GR7_proxy) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR8
by pat_epi : egen GR8_tri1 = sum(GR8_preferences) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR8_tri2 = sum(GR8_preferences) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR8_tri3 = sum(GR8_preferences) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date
// GR9
by pat_epi : egen GR9_tri1 = sum(GR9_custom) if se_start_mdy >= est_del_date - 280 & se_start_mdy <= est_del_date - 183
by pat_epi : egen GR9_tri2 = sum(GR9_custom) if se_start_mdy > est_del_date - 183 & se_start_mdy <= est_del_date - 85
by pat_epi : egen GR9_tri3 = sum(GR9_custom) if se_start_mdy > est_del_date - 85 & se_start_mdy <= est_del_date

///// Now get the max sum of function use in each trimester. This value will be the same as the one repeated across every session in the trimester, but it will now populate for every session of the pat_epi
// GR1
egen sum_GR1_tri1 = max(GR1_tri1), by(pat_epi)
egen sum_GR1_tri2 = max(GR1_tri2), by(pat_epi)
egen sum_GR1_tri3 = max(GR1_tri3), by(pat_epi)
// GR2
egen sum_GR2_tri1 = max(GR2_tri1), by(pat_epi)
egen sum_GR2_tri2 = max(GR2_tri2), by(pat_epi)
egen sum_GR2_tri3 = max(GR2_tri3), by(pat_epi)
// GR3
egen sum_GR3_tri1 = max(GR3_tri1), by(pat_epi)
egen sum_GR3_tri2 = max(GR3_tri2), by(pat_epi)
egen sum_GR3_tri3 = max(GR3_tri3), by(pat_epi)
// GR4
egen sum_GR4_tri1 = max(GR4_tri1), by(pat_epi)
egen sum_GR4_tri2 = max(GR4_tri2), by(pat_epi)
egen sum_GR4_tri3 = max(GR4_tri3), by(pat_epi)
// GR5
egen sum_GR5_tri1 = max(GR5_tri1), by(pat_epi)
egen sum_GR5_tri2 = max(GR5_tri2), by(pat_epi)
egen sum_GR5_tri3 = max(GR5_tri3), by(pat_epi)
// GR6
egen sum_GR6_tri1 = max(GR6_tri1), by(pat_epi)
egen sum_GR6_tri2 = max(GR6_tri2), by(pat_epi)
egen sum_GR6_tri3 = max(GR6_tri3), by(pat_epi)
// GR7
egen sum_GR7_tri1 = max(GR7_tri1), by(pat_epi)
egen sum_GR7_tri2 = max(GR7_tri2), by(pat_epi)
egen sum_GR7_tri3 = max(GR7_tri3), by(pat_epi)
// GR8
egen sum_GR8_tri1 = max(GR8_tri1), by(pat_epi)
egen sum_GR8_tri2 = max(GR8_tri2), by(pat_epi)
egen sum_GR8_tri3 = max(GR8_tri3), by(pat_epi)
// GR9
egen sum_GR9_tri1 = max(GR9_tri1), by(pat_epi)
egen sum_GR9_tri2 = max(GR9_tri2), by(pat_epi)
egen sum_GR9_tri3 = max(GR9_tri3), by(pat_epi)

///// Now replace every value after the first row of each pat_epi with "." so that we are left with only one sum of function use per pat_epi.
// GR1
by pat_epi : replace sum_GR1_tri1 = . if sum_GR1_tri1 == sum_GR1_tri1[1] & _n > 1
by pat_epi : replace sum_GR1_tri2 = . if sum_GR1_tri2 == sum_GR1_tri2[1] & _n > 1
by pat_epi : replace sum_GR1_tri3 = . if sum_GR1_tri3 == sum_GR1_tri3[1] & _n > 1
// GR2
by pat_epi : replace sum_GR2_tri1 = . if sum_GR2_tri1 == sum_GR2_tri1[1] & _n > 1
by pat_epi : replace sum_GR2_tri2 = . if sum_GR2_tri2 == sum_GR2_tri2[1] & _n > 1
by pat_epi : replace sum_GR2_tri3 = . if sum_GR2_tri3 == sum_GR2_tri3[1] & _n > 1
// GR3
by pat_epi : replace sum_GR3_tri1 = . if sum_GR3_tri1 == sum_GR3_tri1[1] & _n > 1
by pat_epi : replace sum_GR3_tri2 = . if sum_GR3_tri2 == sum_GR3_tri2[1] & _n > 1
by pat_epi : replace sum_GR3_tri3 = . if sum_GR3_tri3 == sum_GR3_tri3[1] & _n > 1
// GR4
by pat_epi : replace sum_GR4_tri1 = . if sum_GR4_tri1 == sum_GR4_tri1[1] & _n > 1
by pat_epi : replace sum_GR4_tri2 = . if sum_GR4_tri2 == sum_GR4_tri2[1] & _n > 1
by pat_epi : replace sum_GR4_tri3 = . if sum_GR4_tri3 == sum_GR4_tri3[1] & _n > 1
// GR5
by pat_epi : replace sum_GR5_tri1 = . if sum_GR5_tri1 == sum_GR5_tri1[1] & _n > 1
by pat_epi : replace sum_GR5_tri2 = . if sum_GR5_tri2 == sum_GR5_tri2[1] & _n > 1
by pat_epi : replace sum_GR5_tri3 = . if sum_GR5_tri3 == sum_GR5_tri3[1] & _n > 1
// GR6
by pat_epi : replace sum_GR6_tri1 = . if sum_GR6_tri1 == sum_GR6_tri1[1] & _n > 1
by pat_epi : replace sum_GR6_tri2 = . if sum_GR6_tri2 == sum_GR6_tri2[1] & _n > 1
by pat_epi : replace sum_GR6_tri3 = . if sum_GR6_tri3 == sum_GR6_tri3[1] & _n > 1
// GR7
by pat_epi : replace sum_GR7_tri1 = . if sum_GR7_tri1 == sum_GR7_tri1[1] & _n > 1
by pat_epi : replace sum_GR7_tri2 = . if sum_GR7_tri2 == sum_GR7_tri2[1] & _n > 1
by pat_epi : replace sum_GR7_tri3 = . if sum_GR7_tri3 == sum_GR7_tri3[1] & _n > 1
// GR8
by pat_epi : replace sum_GR8_tri1 = . if sum_GR8_tri1 == sum_GR8_tri1[1] & _n > 1
by pat_epi : replace sum_GR8_tri2 = . if sum_GR8_tri2 == sum_GR8_tri2[1] & _n > 1
by pat_epi : replace sum_GR8_tri3 = . if sum_GR8_tri3 == sum_GR8_tri3[1] & _n > 1
// GR9
by pat_epi : replace sum_GR9_tri1 = . if sum_GR9_tri1 == sum_GR9_tri1[1] & _n > 1
by pat_epi : replace sum_GR9_tri2 = . if sum_GR9_tri2 == sum_GR9_tri2[1] & _n > 1
by pat_epi : replace sum_GR9_tri3 = . if sum_GR9_tri3 == sum_GR9_tri3[1] & _n > 1

collapse sum_GR1_tri1-sum_GR9_tri3, by(pat_epi risk)

save "`out_dir'/MCA_sumuse_pregtri", replace
