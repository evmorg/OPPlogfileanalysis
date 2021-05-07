// version 16.1
// collapse cluster name in each file. Then add rows, don't merge. 
include project_paths.do

use "`out_dir'/Clusters/cluster_norm_tri1.dta", clear
cluster generate clus_norm_tri1 = groups(3), name(clus_norm_tri1) ties(error)
tostring clus_norm_tri1, replace
replace clus_norm_tri1 = "Average Users" if clus_norm_tri1 == "1"
replace clus_norm_tri1 = "Intense Digital Engagers" if clus_norm_tri1 == "2"
replace clus_norm_tri1 = "Resulters" if clus_norm_tri1 == "3"
replace clus_norm_tri1 = "Non-Users" if clus_norm_tri1 == "."
tab clus_norm_tri1
keep pat_epi clus_norm_tri1_id clus_norm_tri1
gen tri = 1
rename clus_norm_tri1_id clus_norm_id
rename clus_norm_tri1 clus_norm
save "`out_dir'/Sankey/sank_norm_tri1.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_norm_tri2.dta", clear
cluster generate clus_norm_tri2 = groups(3), name(clus_norm_tri2) ties(error)
tostring clus_norm_tri2, replace
replace clus_norm_tri2 = "Intense Digital Engagers" if clus_norm_tri2 == "1"
replace clus_norm_tri2 = "Average Users" if clus_norm_tri2 == "2"
replace clus_norm_tri2 = "Prepared Engagers" if clus_norm_tri2 == "3"
replace clus_norm_tri2 = "Non-Users" if clus_norm_tri2 == "."
tab clus_norm_tri2
keep pat_epi clus_norm_tri2_id clus_norm_tri2
gen tri = 2
rename clus_norm_tri2_id clus_norm_id
rename clus_norm_tri2 clus_norm
save "`out_dir'/Sankey/sank_norm_tri2.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_norm_tri3.dta", clear
cluster generate clus_norm_tri3 = groups(4), name(clus_norm_tri3) ties(error)
tostring clus_norm_tri3, replace
replace clus_norm_tri3 = "Average Users" if clus_norm_tri3 == "1"
replace clus_norm_tri3 = "Intense Digital Engagers" if clus_norm_tri3 == "2"
replace clus_norm_tri3 = "Resulters" if clus_norm_tri3 == "3"
replace clus_norm_tri3 = "Schedulers" if clus_norm_tri3 == "4"
replace clus_norm_tri3 = "Non-Users" if clus_norm_tri3 == "."
tab clus_norm_tri3
keep pat_epi clus_norm_tri3_id clus_norm_tri3
gen tri = 3
rename clus_norm_tri3_id clus_norm_id
rename clus_norm_tri3 clus_norm
save "`out_dir'/Sankey/sank_norm_tri3.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_norm.dta", clear
cluster generate clus_norm = groups(3), name(clus_norm) ties(error)
tostring clus_norm, replace
replace clus_norm = "Average Users" if clus_norm == "1"
replace clus_norm = "Intense Digital Engagers" if clus_norm == "2"
replace clus_norm = "Prepared Engagers" if clus_norm == "3"
replace clus_norm = "Non-Users" if clus_norm == "."
tab clus_norm
keep pat_epi clus_norm_id clus_norm
gen tri = 4
save "`out_dir'/Sankey/sank_norm_triall.dta", replace

include project_paths.do
use "`out_dir'/Sankey/sank_norm_tri1.dta", clear
append using "`out_dir'/Sankey/sank_norm_tri2.dta"
append using "`out_dir'/Sankey/sank_norm_tri3.dta"
append using "`out_dir'/Sankey/sank_norm_triall.dta"

save "`out_dir'/Sankey/sank_norm_fin.dta", replace

tab clus_norm tri

export delimited "`out_dir'/Sankey/sank_norm_fin.csv", replace
