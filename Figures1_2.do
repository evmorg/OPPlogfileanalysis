// version 16.1
include project_paths.do

use "`out_dir'/MCA_avguse_pregtri_final.dta", clear

twoway (scatter sum_avg_GR_all sum_avg_GR_norm sum_avg_GR_high preg_tri) ///
       (lfit sum_avg_GR_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit sum_avg_GR_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit sum_avg_GR_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("All Function Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_allactivities_best.pdf", as(pdf) name("Graph") replace
regress sum_avg_GR_all preg_tri 
regress sum_avg_GR_norm preg_tri 
regress sum_avg_GR_high preg_tri 

twoway (scatter avg_GR1_tri_all avg_GR1_tri_norm avg_GR1_tri_high preg_tri) ///
       (lfit avg_GR1_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR1_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR1_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Messaging Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR1messaging.pdf", as(pdf) name("Graph") replace
regress avg_GR1_tri_all preg_tri 
regress avg_GR1_tri_norm preg_tri 
regress avg_GR1_tri_high preg_tri 

twoway (scatter avg_GR2_tri_all avg_GR2_tri_norm avg_GR2_tri_high preg_tri) ///
       (lfit avg_GR2_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR2_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR2_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Visits Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR2visits.pdf", as(pdf) name("Graph") replace
regress avg_GR2_tri_all preg_tri 
regress avg_GR2_tri_norm preg_tri 
regress avg_GR2_tri_high preg_tri 

twoway (scatter avg_GR3_tri_all avg_GR3_tri_norm avg_GR3_tri_high preg_tri) ///
       (lfit avg_GR3_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR3_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR3_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("My Record Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR3myrecord.pdf", as(pdf) name("Graph") replace
regress avg_GR3_tri_all preg_tri 
regress avg_GR3_tri_norm preg_tri 
regress avg_GR3_tri_high preg_tri 

twoway (scatter avg_GR4_tri_all avg_GR4_tri_norm avg_GR4_tri_high preg_tri) ///
       (lfit avg_GR4_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR4_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR4_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Medical Tools Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR4medicaltools.pdf", as(pdf) name("Graph") replace

twoway (scatter avg_GR5_tri_all avg_GR5_tri_norm avg_GR5_tri_high preg_tri) ///
       (lfit avg_GR5_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR5_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR5_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Billing Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR5billing.pdf", as(pdf) name("Graph") replace
regress avg_GR5_tri_all preg_tri 
regress avg_GR5_tri_norm preg_tri 
regress avg_GR5_tri_high preg_tri 

twoway (scatter avg_GR6_tri_all avg_GR6_tri_norm avg_GR6_tri_high preg_tri) ///
       (lfit avg_GR6_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR6_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR6_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Resources Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR6resources.pdf", as(pdf) name("Graph") replace

twoway (scatter avg_GR7_tri_all avg_GR7_tri_norm avg_GR7_tri_high preg_tri) ///
       (lfit avg_GR7_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR7_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR7_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Proxy Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR7proxy.pdf", as(pdf) name("Graph") replace

twoway (scatter avg_GR8_tri_all avg_GR8_tri_norm avg_GR8_tri_high preg_tri) ///
       (lfit avg_GR8_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR8_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR8_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Preferences Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR8preferences.pdf", as(pdf) name("Graph") replace

twoway (scatter avg_GR9_tri_all avg_GR9_tri_norm avg_GR9_tri_high preg_tri) ///
       (lfit avg_GR9_tri_all preg_tri, pstyle(p1) range (1 3) xlabel(1(1)3))  ///
       (lfit avg_GR9_tri_norm preg_tri, pstyle(p2) range (1 3) xlabel(1(1)3))  ///
	   (lfit avg_GR9_tri_high preg_tri, pstyle(p3) range (1 3) xlabel(1(1)3)), ///
       legend(label(1 "All Pregnancies") label(2 "Normal Pregnancies") label(3 "High-risk Pregnancies")) ///
       legend(order(1 2 3)) ///
	   xtitle("Trimester") ///
	   ytitle("Average Function Use") ///
	   title("Custom Use per Trimester")
graph export "`fig_dir'/avguse_pregtri_GR9custom.pdf", as(pdf) name("Graph") replace


