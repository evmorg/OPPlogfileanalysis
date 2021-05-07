// version 16.1
include project_paths.do

// Table 5
use "`out_dir'/MCA_prep_cluster_posthoc", clear

egen age1st_cat = cut(age1st), at(17,20,25,30,35,60) label
label define age1st_cat 0 "<20" 1 "20-24" 2 "25-29" 3 "30-34" 4 "35+" 5 "End", modify
order age1st_cat, a(age1st)

tab age1st_cat
tab race_ethn_cat
tab age1st_cat risk
tab race_ethn_cat risk

