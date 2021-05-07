// version 16.1
include project_paths.do

***** SENSITIVITY ANALYSIS - USE DURING COVID *****
***** Clusters for All Pregnancy Episodes - Normal risk and High-risk

///// Clusters for All Trimesters 
use "`out_dir'/MCA_prep_cluster_posthoc_covid", clear

keep if risk == "Normal"
cluster wardslinkage $rate_vars, measure(L2) name(clus_norm)

save "`out_dir'/Clusters/cluster_norm_covid.dta", replace
include project_paths.do
use "`out_dir'/Clusters/cluster_norm_covid.dta", clear

cluster dendrogram clus_norm, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_normpreg_covid.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(4), name(clus_norm) ties(error)
tab cluster, gen(cluster)

sum $rate_vars if cluster != .
sum $rate_vars if cluster == 1
sum $rate_vars if cluster == 2
sum $rate_vars if cluster == 3
sum $rate_vars if cluster == 4

///// Clusters for Trimester 1
use "`out_dir'/MCA_prep_cluster_posthoc_covid", clear
keep if risk == "Normal"
cluster wardslinkage $rate_vars_tri1, measure(L2) name(clus_norm_tri1)

save "`out_dir'/Clusters/cluster_norm_tri1_covid.dta", replace
include project_paths.do
use "`out_dir'/Clusters/cluster_norm_tri1_covid.dta", clear

cluster dendrogram clus_norm_tri1, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_normpreg_tri1_covid.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(3), name(clus_norm_tri1) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri1 if cluster != .
sum $rate_vars_tri1 if cluster == 1
sum $rate_vars_tri1 if cluster == 2
sum $rate_vars_tri1 if cluster == 3


///// Clusters for Trimester 2
use "`out_dir'/MCA_prep_cluster_posthoc_covid", clear
keep if risk == "Normal"
cluster wardslinkage $rate_vars_tri2, measure(L2) name(clus_norm_tri2)

save "`out_dir'/Clusters/cluster_norm_tri2_covid.dta", replace
include project_paths.do
use "`out_dir'/Clusters/cluster_norm_tri2_covid.dta", clear

cluster dendrogram clus_norm_tri2, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_normpreg_tri2_covid.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(3), name(clus_norm_tri2) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri2 if cluster != .
sum $rate_vars_tri2 if cluster == 1
sum $rate_vars_tri2 if cluster == 2
sum $rate_vars_tri2 if cluster == 3


///// Cluster for Trimester 3
use "`out_dir'/MCA_prep_cluster_posthoc_covid", clear
keep if risk == "Normal"
cluster wardslinkage $rate_vars_tri3, measure(L2) name(clus_norm_tri3)

save "`out_dir'/Clusters/cluster_norm_tri3_covid.dta", replace
include project_paths.do
use "`out_dir'/Clusters/cluster_norm_tri3_covid.dta", clear

cluster dendrogram clus_norm_tri3, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_normpreg_tri3_covid.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(4), name(clus_norm_tri3) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri3 if cluster != .
sum $rate_vars_tri3 if cluster == 1
sum $rate_vars_tri3 if cluster == 2
sum $rate_vars_tri3 if cluster == 3
sum $rate_vars_tri3 if cluster == 4
