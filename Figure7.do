// version 16.1
// collapse cluster name in each file. Then add rows, don't merge. 
include project_paths.do

use "`out_dir'/Clusters/cluster_all_tri1.dta", clear
cluster generate clus_all_tri1 = groups(4), name(clus_all_tri1) ties(error)
tostring clus_all_tri1, replace
replace clus_all_tri1 = "Prepared Engagers" if clus_all_tri1 == "1"
replace clus_all_tri1 = "Intense Digital Engagers" if clus_all_tri1 == "2"
replace clus_all_tri1 = "Average Users" if clus_all_tri1 == "3"
replace clus_all_tri1 = "Exclusive Resulters" if clus_all_tri1 == "4"
replace clus_all_tri1 = "Non-Users" if clus_all_tri1 == "."
tab clus_all_tri1
keep pat_epi clus_all_tri1_id clus_all_tri1
gen tri = 1
rename clus_all_tri1_id clus_all_id
rename clus_all_tri1 clus_all
save "`out_dir'/Sankey/sank_all_tri1.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all_tri2.dta", clear
cluster generate clus_all_tri2 = groups(5), name(clus_all_tri2) ties(error)
tostring clus_all_tri2, replace
replace clus_all_tri2 = "Average Users" if clus_all_tri2 == "1"
replace clus_all_tri2 = "Average Billers" if clus_all_tri2 == "2"
replace clus_all_tri2 = "Resulters" if clus_all_tri2 == "3"
replace clus_all_tri2 = "Intense Digital Engagers" if clus_all_tri2 == "4"
replace clus_all_tri2 = "Schedulers" if clus_all_tri2 == "5"
replace clus_all_tri2 = "Non-Users" if clus_all_tri2 == "."
tab clus_all_tri2
keep pat_epi clus_all_tri2_id clus_all_tri2
gen tri = 2
rename clus_all_tri2_id clus_all_id
rename clus_all_tri2 clus_all
save "`out_dir'/Sankey/sank_all_tri2.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all_tri3.dta", clear
cluster generate clus_all_tri3 = groups(4), name(clus_all_tri3) ties(error)
tostring clus_all_tri3, replace
replace clus_all_tri3 = "Average Users" if clus_all_tri3 == "1"
replace clus_all_tri3 = "Resulters" if clus_all_tri3 == "2"
replace clus_all_tri3 = "Intense Digital Engagers" if clus_all_tri3 == "3"
replace clus_all_tri3 = "Schedulers" if clus_all_tri3 == "4"
replace clus_all_tri3 = "Non-Users" if clus_all_tri3 == "."
tab clus_all_tri3
keep pat_epi clus_all_tri3_id clus_all_tri3
gen tri = 3
rename clus_all_tri3_id clus_all_id
rename clus_all_tri3 clus_all
save "`out_dir'/Sankey/sank_all_tri3.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all.dta", clear
cluster generate clus_all = groups(4), name(clus_all) ties(error)
tostring clus_all, replace
replace clus_all = "Average Users" if clus_all == "1"
replace clus_all = "Intense Digital Engagers" if clus_all == "2"
replace clus_all = "Prepared Engagers" if clus_all == "3"
replace clus_all = "Schedulers" if clus_all == "4"
replace clus_all = "Non-Users" if clus_all == "."
tab clus_all
keep pat_epi clus_all_id clus_all
gen tri = 4
save "`out_dir'/Sankey/sank_all_triall.dta", replace

include project_paths.do
use "`out_dir'/Sankey/sank_all_tri1.dta", clear
append using "`out_dir'/Sankey/sank_all_tri2.dta"
append using "`out_dir'/Sankey/sank_all_tri3.dta"
append using "`out_dir'/Sankey/sank_all_triall.dta"

save "`out_dir'/Sankey/sank_all_fin.dta", replace

tab clus_all tri

export delimited "`out_dir'/Sankey/sank_all_fin.csv", replace
