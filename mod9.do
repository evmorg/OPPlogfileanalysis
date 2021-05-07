// version 16.1
include project_paths.do

use "`out_dir'/MCA_sessions_w_tri_active_status", clear

// Pregnancy episode level frequency of use for each portal function 
// Multiple uses of an action type in a session returns 1 use of the function in a session. Here it is summing the number of times a function was used in the sessions of an episode, not the number of times an action was used in the sessions of an episode.

by pat_epi : egen GR1_epi = sum(GR1_messaging)
by pat_epi : egen GR2_epi = sum(GR2_visits)
by pat_epi : egen GR3_epi = sum(GR3_myrecord)
by pat_epi : egen GR4_epi = sum(GR4_medicaltools)
by pat_epi : egen GR5_epi = sum(GR5_billing)
by pat_epi : egen GR6_epi = sum(GR6_resources)
by pat_epi : egen GR7_epi = sum(GR7_proxy)
by pat_epi : egen GR8_epi = sum(GR8_preferences)
by pat_epi : egen GR9_epi = sum(GR9_custom)

by pat_epi : replace GR1_epi = . if GR1_epi == GR1_epi[1] & _n > 1
by pat_epi : replace GR2_epi = . if GR2_epi == GR2_epi[1] & _n > 1
by pat_epi : replace GR3_epi = . if GR3_epi == GR3_epi[1] & _n > 1
by pat_epi : replace GR4_epi = . if GR4_epi == GR4_epi[1] & _n > 1
by pat_epi : replace GR5_epi = . if GR5_epi == GR5_epi[1] & _n > 1
by pat_epi : replace GR6_epi = . if GR6_epi == GR6_epi[1] & _n > 1
by pat_epi : replace GR7_epi = . if GR7_epi == GR7_epi[1] & _n > 1
by pat_epi : replace GR8_epi = . if GR8_epi == GR8_epi[1] & _n > 1
by pat_epi : replace GR9_epi = . if GR9_epi == GR9_epi[1] & _n > 1

// Pregnancy episode level frequency of use for each action type
// Multiple uses of an action type in a session occur. Each use of an action has already been counted vai mod7 to return the number of action uses in a session. Here it is summing the action use in the sessions of an episode.

by pat_epi : egen GR1_message_center_epi = sum(GR1_message_center_f)
by pat_epi : egen GR1_send_new_message_epi = sum(GR1_send_new_message_f)
by pat_epi : egen GR1_letters_epi = sum(GR1_letters_f)
by pat_epi : egen GR2_appointment_details_epi = sum(GR2_appointment_details_f)
by pat_epi : egen GR2_driving_directions_epi = sum(GR2_driving_directions_f)
by pat_epi : egen GR2_echeck_in_epi = sum(GR2_echeck_in_f)
by pat_epi : egen GR2_telemedicine_epi = sum(GR2_telemedicine_f)
by pat_epi : egen GR2_upcoming_tests_epi = sum(GR2_schedule_an_appointment_f)
by pat_epi : egen GR2_cancel_an_appointment_epi = sum(GR2_cancel_an_appointment_f)
by pat_epi : egen GR3_my_conditions_epi = sum(GR3_my_conditions_f)
by pat_epi : egen GR3_flowsheet_epi = sum(GR3_flowsheet_f)
by pat_epi : egen GR3_test_results_epi = sum(GR3_test_results_f)
by pat_epi : egen GR3_health_summary_epi = sum(GR3_health_summary_f)
by pat_epi : egen GR3_current_health_issues_epi = sum(GR3_current_health_issues_f)
by pat_epi : egen GR3_medications_epi = sum(GR3_medications_f)
by pat_epi : egen GR3_allergies_epi = sum(GR3_allergies_f)
by pat_epi : egen GR3_preventive_care_epi = sum(GR3_preventive_care_f)
by pat_epi : egen GR3_immunizations_epi = sum(GR3_immunizations_f)
by pat_epi : egen GR4_consolidate_EHR_epi = sum(GR4_consolidate_EHR_f)
by pat_epi : egen GR4_download_my_record_epi = sum(GR4_download_my_record_f)
by pat_epi : egen GR4_who_accessed_my_record_epi = sum(GR4_who_accessed_my_record_f)
by pat_epi : egen GR4_research_studies_epi = sum(GR4_research_studies_f)
by pat_epi : egen GR4_wallet_card_epi = sum(GR4_wallet_card_f)
by pat_epi : egen GR4_share_my_record_epi = sum(GR4_share_my_record_f)
by pat_epi : egen GR5_billing_account_summary_epi = sum(GR5_billing_account_summary_f)
by pat_epi : egen GR5_billing_account_details_epi = sum(GR5_billing_account_details_f)
by pat_epi : egen GR5_bill_payment_epi = sum(GR5_bill_payment_f)
by pat_epi : egen GR5_change_paperless_status_epi = sum(GR5_change_paperless_status_f)
by pat_epi : egen GR5_insurance_summary_epi = sum(GR5_insurance_summary_f)
by pat_epi : egen GR5_update_insurance_epi = sum(GR5_update_insurance_f)
by pat_epi : egen GR5_estimates_epi = sum(GR5_estimates_f)
by pat_epi : egen GR6_terms_and_conditions_epi = sum(GR6_terms_and_conditions_f)
by pat_epi : egen GR6_osuwmc_patient_education_epi = sum(GR6_osuwmc_patient_education_f)
by pat_epi : egen GR6_krames_patient_education_epi = sum(GR6_krames_patient_education_f)
by pat_epi : egen GR6_locations_epi = sum(GR6_locations_f)
by pat_epi : egen GR7_proxy_forms_epi = sum(GR7_proxy_forms_f)
by pat_epi : egen GR7_switch_proxy_context_epi = sum(GR7_switch_proxy_context_f)
by pat_epi : egen GR7_request_proxy_access_epi = sum(GR7_request_proxy_access_f)
by pat_epi : egen GR7_request_child_proxy_epi = sum(GR7_request_child_proxy_access_f)
by pat_epi : egen GR7_proxy_renewal_request_epi = sum(GR7_proxy_renewal_request_f)
by pat_epi : egen GR8_personalize_epi = sum(GR8_personalize_f)
by pat_epi : egen GR8_about_me_epi = sum(GR8_about_me_f)
by pat_epi : egen GR8_security_settings_epi = sum(GR8_security_settings_f)
by pat_epi : egen GR8_notifications_epi = sum(GR8_notifications_f)
by pat_epi : egen GR8_manage_my_accounts_epi = sum(GR8_manage_my_accounts_f)
by pat_epi : egen GR9_miscellanea_epi = sum(GR9_miscellanea_f)

by pat_epi : replace GR1_message_center_epi = . if GR1_message_center_epi == GR1_message_center_epi[1] & _n > 1 
by pat_epi : replace GR1_send_new_message_epi = . if GR1_send_new_message_epi == GR1_send_new_message_epi[1] & _n > 1 
by pat_epi : replace GR1_letters_epi = . if GR1_letters_epi == GR1_letters_epi[1] & _n > 1 
by pat_epi : replace GR2_appointment_details_epi = . if GR2_appointment_details_epi == GR2_appointment_details_epi[1] & _n > 1 
by pat_epi : replace GR2_driving_directions_epi = . if GR2_driving_directions_epi == GR2_driving_directions_epi[1] & _n > 1 
by pat_epi : replace GR2_echeck_in_epi = . if GR2_echeck_in_epi == GR2_echeck_in_epi[1] & _n > 1 
by pat_epi : replace GR2_telemedicine_epi = . if GR2_telemedicine_epi == GR2_telemedicine_epi[1] & _n > 1 
by pat_epi : replace GR2_upcoming_tests_epi = . if GR2_upcoming_tests_epi == GR2_upcoming_tests_epi[1] & _n > 1 
by pat_epi : replace GR2_cancel_an_appointment_epi = . if GR2_cancel_an_appointment_epi == GR2_cancel_an_appointment_epi[1] & _n > 1 
by pat_epi : replace GR3_my_conditions_epi = . if GR3_my_conditions_epi == GR3_my_conditions_epi[1] & _n > 1 
by pat_epi : replace GR3_flowsheet_epi = . if GR3_flowsheet_epi == GR3_flowsheet_epi[1] & _n > 1 
by pat_epi : replace GR3_test_results_epi = . if GR3_test_results_epi == GR3_test_results_epi[1] & _n > 1 
by pat_epi : replace GR3_health_summary_epi = . if GR3_health_summary_epi == GR3_health_summary_epi[1] & _n > 1 
by pat_epi : replace GR3_current_health_issues_epi = . if GR3_current_health_issues_epi == GR3_current_health_issues_epi[1] & _n > 1 
by pat_epi : replace GR3_medications_epi = . if GR3_medications_epi == GR3_medications_epi[1] & _n > 1 
by pat_epi : replace GR3_allergies_epi = . if GR3_allergies_epi == GR3_allergies_epi[1] & _n > 1 
by pat_epi : replace GR3_preventive_care_epi = . if GR3_preventive_care_epi == GR3_preventive_care_epi[1] & _n > 1 
by pat_epi : replace GR3_immunizations_epi = . if GR3_immunizations_epi == GR3_immunizations_epi[1] & _n > 1 
by pat_epi : replace GR4_consolidate_EHR_epi = . if GR4_consolidate_EHR_epi == GR4_consolidate_EHR_epi[1] & _n > 1 
by pat_epi : replace GR4_download_my_record_epi = . if GR4_download_my_record_epi == GR4_download_my_record_epi[1] & _n > 1 
by pat_epi : replace GR4_who_accessed_my_record_epi = . if GR4_who_accessed_my_record_epi == GR4_who_accessed_my_record_epi[1] & _n > 1 
by pat_epi : replace GR4_research_studies_epi = . if GR4_research_studies_epi == GR4_research_studies_epi[1] & _n > 1 
by pat_epi : replace GR4_wallet_card_epi = . if GR4_wallet_card_epi == GR4_wallet_card_epi[1] & _n > 1 
by pat_epi : replace GR4_share_my_record_epi = . if GR4_share_my_record_epi == GR4_share_my_record_epi[1] & _n > 1 
by pat_epi : replace GR5_billing_account_summary_epi = . if GR5_billing_account_summary_epi == GR5_billing_account_summary_epi[1] & _n > 1 
by pat_epi : replace GR5_billing_account_details_epi = . if GR5_billing_account_details_epi == GR5_billing_account_details_epi[1] & _n > 1 
by pat_epi : replace GR5_bill_payment_epi = . if GR5_bill_payment_epi == GR5_bill_payment_epi[1] & _n > 1 
by pat_epi : replace GR5_change_paperless_status_epi = . if GR5_change_paperless_status_epi == GR5_change_paperless_status_epi[1] & _n > 1 
by pat_epi : replace GR5_insurance_summary_epi = . if GR5_insurance_summary_epi == GR5_insurance_summary_epi[1] & _n > 1 
by pat_epi : replace GR5_update_insurance_epi = . if GR5_update_insurance_epi == GR5_update_insurance_epi[1] & _n > 1 
by pat_epi : replace GR5_estimates_epi = . if GR5_estimates_epi == GR5_estimates_epi[1] & _n > 1 
by pat_epi : replace GR6_terms_and_conditions_epi = . if GR6_terms_and_conditions_epi == GR6_terms_and_conditions_epi[1] & _n > 1 
by pat_epi : replace GR6_osuwmc_patient_education_epi = . if GR6_osuwmc_patient_education_epi == GR6_osuwmc_patient_education_epi[1] & _n > 1 
by pat_epi : replace GR6_krames_patient_education_epi = . if GR6_krames_patient_education_epi == GR6_krames_patient_education_epi[1] & _n > 1 
by pat_epi : replace GR6_locations_epi = . if GR6_locations_epi == GR6_locations_epi[1] & _n > 1 
by pat_epi : replace GR7_proxy_forms_epi = . if GR7_proxy_forms_epi == GR7_proxy_forms_epi[1] & _n > 1 
by pat_epi : replace GR7_switch_proxy_context_epi = . if GR7_switch_proxy_context_epi == GR7_switch_proxy_context_epi[1] & _n > 1 
by pat_epi : replace GR7_request_proxy_access_epi = . if GR7_request_proxy_access_epi == GR7_request_proxy_access_epi[1] & _n > 1 
by pat_epi : replace GR7_request_child_proxy_epi = . if GR7_request_child_proxy_epi == GR7_request_child_proxy_epi[1] & _n > 1 
by pat_epi : replace GR7_proxy_renewal_request_epi = . if GR7_proxy_renewal_request_epi == GR7_proxy_renewal_request_epi[1] & _n > 1 
by pat_epi : replace GR8_personalize_epi = . if GR8_personalize_epi == GR8_personalize_epi[1] & _n > 1 
by pat_epi : replace GR8_about_me_epi = . if GR8_about_me_epi == GR8_about_me_epi[1] & _n > 1 
by pat_epi : replace GR8_security_settings_epi = . if GR8_security_settings_epi == GR8_security_settings_epi[1] & _n > 1 
by pat_epi : replace GR8_notifications_epi = . if GR8_notifications_epi == GR8_notifications_epi[1] & _n > 1 
by pat_epi : replace GR8_manage_my_accounts_epi = . if GR8_manage_my_accounts_epi == GR8_manage_my_accounts_epi[1] & _n > 1 
by pat_epi : replace GR9_miscellanea_epi = . if GR9_miscellanea_epi == GR9_miscellanea_epi[1] & _n > 1  

save "`out_dir'/MCA_action_function_use", replace
