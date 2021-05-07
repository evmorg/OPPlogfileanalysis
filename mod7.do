// version 16.1
include project_paths.do

use "`out_dir'/MCA_tasks", clear

/* REMOVE_DUPLICATE_TASKS */
gen clean_extended_info = ext_info 

forval j = 0/9 {
	replace clean_extended_info = subinstr(clean_extended_info, "`j'", "", .)
}

replace clean_extended_info = strtrim(clean_extended_info)

gen dup = 0
replace dup = 1 if act_type == act_type[_n - 1] & clean_extended_info == clean_extended_info[_n - 1] & se_id == se_id[_n - 1]
drop if dup == 1
drop dup clean_extended_info

// Exclude "Logout" from activity counters
drop if act_type == "Logout"

/* INITIALIZE ACTIVITY COUNTERS */
gen GR1_messaging = 0
gen GR2_visits = 0
gen GR3_myrecord = 0
gen GR4_medicaltools = 0
gen GR5_billing = 0
gen GR6_resources = 0
gen GR7_proxy = 0
gen GR8_preferences = 0
gen GR9_custom = 0

replace GR1_messaging = 1 if act_mca_activity_group =="Messaging" & act_active == 1
replace GR2_visits = 1 if act_mca_activity_group =="Visits" & act_active == 1
replace GR3_myrecord = 1 if act_mca_activity_group =="What's in my record" & act_active == 1
replace GR4_medicaltools = 1 if act_mca_activity_group =="Medical Tools" & act_active == 1
replace GR5_billing = 1 if act_mca_activity_group =="Billing" & act_active == 1
replace GR6_resources = 1 if act_mca_activity_group =="Resources" & act_active == 1
replace GR7_proxy = 1 if act_mca_activity_group =="Proxy Forms" & act_active == 1
replace GR8_preferences = 1 if act_mca_activity_group =="Preferences" & act_active == 1
replace GR9_custom = 1 if act_mca_activity_group =="Misc." & act_active == 1

gen GR1_message_center_f = 0
gen GR1_send_new_message_f = 0
gen GR1_letters_f = 0
gen GR2_appointment_details_f = 0
gen GR2_driving_directions_f = 0
gen GR2_echeck_in_f = 0
gen GR2_telemedicine_f = 0
gen GR2_upcoming_tests_f = 0
gen GR2_schedule_an_appointment_f = 0
gen GR2_cancel_an_appointment_f = 0
gen GR3_my_conditions_f = 0
gen GR3_flowsheet_f = 0
gen GR3_test_results_f = 0
gen GR3_health_summary_f = 0
gen GR3_current_health_issues_f = 0
gen GR3_medications_f = 0
gen GR3_allergies_f = 0
gen GR3_preventive_care_f = 0
gen GR3_immunizations_f = 0
gen GR4_consolidate_EHR_f = 0
gen GR4_download_my_record_f = 0
gen GR4_who_accessed_my_record_f = 0
gen GR4_research_studies_f = 0
gen GR4_wallet_card_f = 0
gen GR4_share_my_record_f = 0
gen GR5_billing_account_summary_f = 0
gen GR5_billing_account_details_f = 0
gen GR5_bill_payment_f = 0
gen GR5_change_paperless_status_f = 0
gen GR5_insurance_summary_f = 0
gen GR5_update_insurance_f = 0
gen GR5_estimates_f = 0
gen GR6_terms_and_conditions_f = 0
gen GR6_osuwmc_patient_education_f = 0
gen GR6_krames_patient_education_f = 0
gen GR6_locations_f = 0
gen GR7_proxy_forms_f = 0
gen GR7_switch_proxy_context_f = 0
gen GR7_request_proxy_access_f = 0
gen GR7_request_child_proxy_access_f = 0
gen GR7_proxy_renewal_request_f = 0
gen GR8_personalize_f = 0
gen GR8_about_me_f = 0
gen GR8_security_settings_f = 0
gen GR8_notifications_f = 0
gen GR8_manage_my_accounts_f = 0
gen GR9_miscellanea_f = 0
replace GR1_message_center_f = 1 if act_mca_activity == "message center" & act_active == 1
replace GR1_send_new_message_f = 1 if act_mca_activity == "send new message" & act_active == 1
replace GR1_letters_f = 1 if act_mca_activity == "letters" & act_active == 1
replace GR2_appointment_details_f = 1 if act_mca_activity == "appointment details" & act_active == 1
replace GR2_driving_directions_f = 1 if act_mca_activity == "driving directions" & act_active == 1
replace GR2_echeck_in_f = 1 if act_mca_activity == "echeck in" & act_active == 1
replace GR2_telemedicine_f = 1 if act_mca_activity == "telemedicine" & act_active == 1
replace GR2_upcoming_tests_f = 1 if act_mca_activity == "upcoming tests" & act_active == 1
replace GR2_schedule_an_appointment_f = 1 if act_mca_activity == "schedule an appointment" & act_active == 1
replace GR2_cancel_an_appointment_f = 1 if act_mca_activity == "cancel an appointment" & act_active == 1
replace GR3_my_conditions_f = 1 if act_mca_activity == "my conditions" & act_active == 1
replace GR3_flowsheet_f = 1 if act_mca_activity == "flowsheet" & act_active == 1
replace GR3_test_results_f = 1 if act_mca_activity == "test results" & act_active == 1
replace GR3_health_summary_f = 1 if act_mca_activity == "health summary" & act_active == 1
replace GR3_current_health_issues_f = 1 if act_mca_activity == "current health issues" & act_active == 1
replace GR3_medications_f = 1 if act_mca_activity == "medications" & act_active == 1
replace GR3_allergies_f = 1 if act_mca_activity == "allergies" & act_active == 1
replace GR3_preventive_care_f = 1 if act_mca_activity == "preventive care" & act_active == 1
replace GR3_immunizations_f = 1 if act_mca_activity == "immunizations" & act_active == 1
replace GR4_consolidate_EHR_f = 1 if act_mca_activity == "consolidate EHR" & act_active == 1
replace GR4_download_my_record_f = 1 if act_mca_activity == "download my record" & act_active == 1
replace GR4_who_accessed_my_record_f = 1 if act_mca_activity == "who accessed my record" & act_active == 1
replace GR4_research_studies_f = 1 if act_mca_activity == "research studies" & act_active == 1
replace GR4_wallet_card_f = 1 if act_mca_activity == "wallet card" & act_active == 1
replace GR4_share_my_record_f = 1 if act_mca_activity == "share my record" & act_active == 1
replace GR5_billing_account_summary_f = 1 if act_mca_activity == "billing account summary" & act_active == 1
replace GR5_billing_account_details_f = 1 if act_mca_activity == "billing account details" & act_active == 1
replace GR5_bill_payment_f = 1 if act_mca_activity == "bill payment" & act_active == 1
replace GR5_change_paperless_status_f = 1 if act_mca_activity == "change paperless status" & act_active == 1
replace GR5_insurance_summary_f = 1 if act_mca_activity == "insurance summary" & act_active == 1
replace GR5_update_insurance_f = 1 if act_mca_activity == "update insurance" & act_active == 1
replace GR5_estimates_f = 1 if act_mca_activity == "estimates" & act_active == 1
replace GR6_terms_and_conditions_f = 1 if act_mca_activity == "terms and conditions" & act_active == 1
replace GR6_osuwmc_patient_education_f = 1 if act_mca_activity == "osuwmc patient education" & act_active == 1
replace GR6_krames_patient_education_f = 1 if act_mca_activity == "krames patient education" & act_active == 1
replace GR6_locations_f = 1 if act_mca_activity == "locations" & act_active == 1
replace GR7_proxy_forms_f = 1 if act_mca_activity == "proxy forms" & act_active == 1
replace GR7_switch_proxy_context_f = 1 if act_mca_activity == "switch proxy context" & act_active == 1
replace GR7_request_proxy_access_f = 1 if act_mca_activity == "request proxy access" & act_active == 1
replace GR7_request_child_proxy_access_f = 1 if act_mca_activity == "request child proxy access" & act_active == 1
replace GR7_proxy_renewal_request_f = 1 if act_mca_activity == "proxy renewal request" & act_active == 1
replace GR8_personalize_f = 1 if act_mca_activity == "personalize" & act_active == 1
replace GR8_about_me_f = 1 if act_mca_activity == "about me" & act_active == 1
replace GR8_security_settings_f = 1 if act_mca_activity == "security settings" & act_active == 1
replace GR8_notifications_f = 1 if act_mca_activity == "notifications" & act_active == 1
replace GR8_manage_my_accounts_f = 1 if act_mca_activity == "manage my accounts" & act_active == 1
replace GR9_miscellanea_f = 1 if act_mca_activity == "miscellanea" & act_active == 1

/* COMPUTE PER-SESSION ACTIVITY COUNTERS */
sort pat_epi se_id act_date, stable

foreach var of varlist GR* {
	by se_id, sort : replace `var' = sum(`var')
}

by se_id: keep if _n == _N

foreach var of varlist GR1_messaging-GR9_custom {
	replace `var' = 1 if `var' > 1
}

keep pat_num epi_num pat_epi se_id se_device se_num se_start se_effective_length GR*

sort pat_epi se_id
by pat_epi : replace se_num = _n
	 
save "`out_dir'/MCA_sessions", replace
