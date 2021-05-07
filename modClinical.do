// version 16.1
include project_paths.do

import delimited "`in_dir'/OBGYN_PatientPortalUse_NaleefFareed_Table2.csv", encoding(utf8) clear

egen pat_epi = concat(pat_num epi_num), p(".")
destring pat_epi, replace
order pat_epi, a(epi_num)

// Convert contact_date to SIF date
describe contact_date
gen contact_time = date(contact_date, "MD20Y")
order contact_time, a(contact_date)
format contact_time %td
drop contact_date
rename contact_time contact_date
order contact_date, a(pat_epi)
sort pat_epi

///// Clean Up /////

// bmi - Dealing with impossible values
// i.e., bmi > 100
gen bmi_norm = bmi if bmi < 200
gen bmi_norm1 = bmi_norm if bmi_norm > 9
drop bmi_norm
rename bmi_norm1 bmi_norm
sum bmi_norm 
order bmi_norm, a(bmi)
// hist bmi_norm

// hgba1c - Dealing with improperly formatted strings
// i.e., ">15" "4..8" "5.50%" 
gen hgba1c_1 = hgba1c if !(strpos(hgba1c), ">")
gen hgba1c_2 = hgba1c_1 if !(strpos(hgba1c_1), "%")
gen hgba1c_3 = hgba1c_2 if !(strpos(hgba1c_2), "..")
drop hgba1c_1
drop hgba1c_2
rename hgba1c_3 hgba1c_num
order hgba1c_num, a(hgba1c)

destring hgba1c_num, replace

// hgba1c - Dealing with impossible values
// i.e., hgba1c=92 or 601
gen hgba1c_num1 = hgba1c_num if hgba1c_num < 50
drop hgba1c_num
rename hgba1c_num1 hgba1c_num

// bp - Dealing with impossible values
gen bp_dias_norm = bp_diastolic if bp_diastolic > 10
sum bp_dias_norm

// bp - Dealing with impossible values
gen bp_syst_norm = bp_systolic if bp_systolic > 10
sum bp_syst_norm

// glucose - Dealing with improperly formatted strings
// i.e., "mg/dL" "neg" " lb"
gen glucose_1 = glucose if !(strpos(glucose), "mg/dL")
gen glucose_2 = glucose_1 if !(strpos(glucose_1), "neg")
gen glucose_3 = glucose_2 if !(strpos(glucose_2), "lb")
drop glucose_1
drop glucose_2
rename glucose_3 glucose_num
order glucose_num, a(glucose)

destring glucose_num, replace

// glucose - Dealing with impossible values
// i.e.,
gen hgba1c_num1 = hgba1c_num if hgba1c_num < 50
drop hgba1c_num
rename hgba1c_num1 hgba1c_num

// urine - Dealing with improperly formatted strings
// i.e., ">15" "4..8" "5.50%" 
gen urine_1 = urine if !(strpos(urine), "<")
gen urine_2 = urine_1 if !(strpos(urine_1), ">")
gen urine_3 = urine_2 if !(strpos(urine_2), "N")
gen urine_4 = urine_3 if !(strpos(urine_3), "T")
gen urine_5 = urine_4 if !(strpos(urine_4), "-")
drop urine_1
drop urine_2
drop urine_3
drop urine_4
rename urine_5 urine_num
order urine_num, a(urine)

destring urine_num, replace

// urine - Dealing with impossible values
// i.e., hgba1c=92 or 601
gen hgba1c_num1 = hgba1c_num if hgba1c_num < 50
drop hgba1c_num
rename hgba1c_num1 hgba1c_num

///// Missing /////

// Number missing for each variable

// Missingness per observation
ssc install mdesc
mdesc 

misschk hgba1c_num glucose_num urine_num, gen(miss)
egen bmi_nmis = rmiss(bmi)
egen hgba1c_nmis = rmiss(hgba1c_num)
egen bpdias_nmis = rmiss(bp_diastolic)
egen bpsys_nmis = rmiss(bp_systolic)
egen gluc_nmis = rmiss(glucose_num)
egen urine_nmis = rmiss(urine_num)

// Missingness per pat_epi (might need to actually do this per pat_num?)
bysort pat_epi : egen bmi_count = count(bmi)
order bmi_count, a(bmi_norm)
by pat_epi : replace bmi_count = . if bmi_count == bmi_count[1] & _n > 1
summarize bmi_count 

bysort pat_epi : egen hgba1c_count = count(hgba1c_num)
order hgba1c_count, a(hgba1c_num)
by pat_epi : replace hgba1c_count = . if hgba1c_count == hgba1c_count[1] & _n > 1
summarize hgba1c_count 

bysort pat_epi : egen dias_count = count(bp_diastolic)
order dias_count, a(bp)
by pat_epi : replace dias_count = . if dias_count == dias_count[1] & _n > 1
summarize dias_count

bysort pat_epi : egen syst_count = count(bp_systolic)
order syst_count, a(dias_count)
by pat_epi : replace syst_count = . if syst_count == syst_count[1] & _n > 1
summarize syst_count

bysort pat_epi : egen glucose_count = count(glucose_num)
order glucose_count, a(glucose_num)
by pat_epi : replace glucose_count = . if glucose_count == glucose_count[1] & _n > 1
summarize glucose_count 

bysort pat_epi : egen urine_count = count(urine_num)
order urine_count, a(urine_num)
by pat_epi : replace urine_count = . if urine_count == urine_count[1] & _n > 1
summarize urine_count 

///// Descriptive Statistics /////

// bmi - Identify and keep the first occurrence of a lab value per pat_epi
gen bmi_norm_miss = missing(bmi_norm)
order bmi_norm_miss, a(bmi_norm)
bysort pat_epi (bmi_norm_miss contact_date): gen bmi_first = bmi_norm[1]
drop bmi_norm_miss
order bmi_first, a(bmi_count)
sort pat_epi contact_date 
by pat_epi : replace bmi_first = . if bmi_first == bmi_first[1] & _n > 1

// hgba1c - Calculate mean per pat_epi
bysort pat_epi : egen hgba1c_mean = mean(hgba1c_num)
order hgba1c_mean, a(hgba1c_count)
by pat_epi : replace hgba1c_mean = . if hgba1c_mean == hgba1c_mean[1] & _n > 1

// bp - Calculate mean per pat_epi
bysort pat_epi : egen dias_mean = mean(bp_diastolic)
order dias_mean, a(dias_count)
by pat_epi : replace dias_mean = . if dias_mean == dias_mean[1] & _n > 1
replace dias_mean = round(dias_mean, 1)

bysort pat_epi : egen syst_mean = mean(bp_systolic)
order syst_mean, a(syst_count)
by pat_epi : replace syst_mean = . if syst_mean == syst_mean[1] & _n > 1
replace syst_mean = round(syst_mean, 1)

// glucose - Calculate mean per pat_epi
bysort pat_epi : egen glucose_mean = mean(glucose_num)
order glucose_mean, a(glucose_count)
by pat_epi : replace glucose_mean = . if glucose_mean == glucose_mean[1] & _n > 1
replace glucose_mean = round(glucose_mean, 1)

// urine - Calculate mean per pat_epi
bysort pat_epi : egen urine_mean = mean(urine_num)
order urine_mean, a(urine_count)
by pat_epi : replace urine_mean = . if urine_mean == urine_mean[1] & _n > 1
replace urine_mean = round(urine_mean, 1)

// dx_cnt - Identify max per pat_epi 
bysort pat_epi : egen dx_max = max(dx_cnt)
order dx_max, a(dx_cnt)
by pat_epi : replace dx_max = . if dx_max == dx_max[1] & _n > 1

// contact_date - Keep only first date
bysort pat_epi : egen contact_first = min(contact_date)
format contact_first %td
order contact_first, a(contact_date)
by pat_epi : replace contact_first = . if contact_first == contact_first[1] & _n > 1

// remove unnecessary variables
drop pat_num epi_num contact_date bmi bmi_norm bmi_count enc_type enc_reason_name prov_name height weight hgba1c bp_diastolic bp_systolic bp glucose glucose_num urine urine_num dx_cnt dx_list


///// Collapse /////

collapse contact_first-dx_max, by(pat_epi)

sort pat_epi 

save "`out_dir'/Clinical_clean", replace
