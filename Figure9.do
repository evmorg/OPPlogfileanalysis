// version 16.1
// collapse cluster name in each file. Then add rows, don't merge. 
include project_paths.do

use "`out_dir'/Clusters/cluster_high_tri1.dta", clear
cluster generate clus_high_tri1 = groups(5), name(clus_high_tri1) ties(error)
tostring clus_high_tri1, replace
replace clus_high_tri1 = "Average Users" if clus_high_tri1 == "1"
replace clus_high_tri1 = "Schedulers" if clus_high_tri1 == "2"
replace clus_high_tri1 = "Intense Digital Engagers" if clus_high_tri1 == "3"
replace clus_high_tri1 = "Exclusive Resulters" if clus_high_tri1 == "4"
replace clus_high_tri1 = "Resulters" if clus_high_tri1 == "5"
replace clus_high_tri1 = "Non-Users" if clus_high_tri1 == "."
tab clus_high_tri1
keep pat_epi clus_high_tri1_id clus_high_tri1
gen tri = 1
rename clus_high_tri1_id clus_high_id
rename clus_high_tri1 clus_high
save "`out_dir'/Sankey/sank_high_tri1.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_high_tri2.dta", clear
cluster generate clus_high_tri2 = groups(4), name(clus_high_tri2) ties(error)
tostring clus_high_tri2, replace
replace clus_high_tri2 = "Schedulers" if clus_high_tri2 == "1"
replace clus_high_tri2 = "Resulters" if clus_high_tri2 == "2"
replace clus_high_tri2 = "Average Users" if clus_high_tri2 == "3"
replace clus_high_tri2 = "Intense Digital Engagers" if clus_high_tri2 == "4"
replace clus_high_tri2 = "Non-Users" if clus_high_tri2 == "."
tab clus_high_tri2
keep pat_epi clus_high_tri2_id clus_high_tri2
gen tri = 2
rename clus_high_tri2_id clus_high_id
rename clus_high_tri2 clus_high
save "`out_dir'/Sankey/sank_high_tri2.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_high_tri3.dta", clear
cluster generate clus_high_tri3 = groups(4), name(clus_high_tri3) ties(error)
tostring clus_high_tri3, replace
replace clus_high_tri3 = "Average Users" if clus_high_tri3 == "1"
replace clus_high_tri3 = "Schedulers" if clus_high_tri3 == "2"
replace clus_high_tri3 = "Resulters" if clus_high_tri3 == "3"
replace clus_high_tri3 = "Intense Digital Engagers" if clus_high_tri3 == "4"
replace clus_high_tri3 = "Non-Users" if clus_high_tri3 == "."
tab clus_high_tri3
keep pat_epi clus_high_tri3_id clus_high_tri3
gen tri = 3
rename clus_high_tri3_id clus_high_id
rename clus_high_tri3 clus_high
save "`out_dir'/Sankey/sank_high_tri3.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_high.dta", clear
cluster generate clus_high = groups(4), name(clus_high) ties(error)
tostring clus_high, replace
replace clus_high = "Prepared Engagers" if clus_high == "1"
replace clus_high = "Schedulers" if clus_high == "2"
replace clus_high = "Resulters" if clus_high == "3"
replace clus_high = "Intense Digital Engagers" if clus_high == "4"
replace clus_high = "Non-Users" if clus_high == "."
tab clus_high
keep pat_epi clus_high_id clus_high
gen tri = 4
save "`out_dir'/Sankey/sank_high_triall.dta", replace

include project_paths.do
use "`out_dir'/Sankey/sank_high_tri1.dta", clear
append using "`out_dir'/Sankey/sank_high_tri2.dta"
append using "`out_dir'/Sankey/sank_high_tri3.dta"
append using "`out_dir'/Sankey/sank_high_triall.dta"

save "`out_dir'/Sankey/sank_high_fin.dta", replace

tab clus_high tri

export delimited "`out_dir'/Sankey/sank_high_fin.csv", replace
