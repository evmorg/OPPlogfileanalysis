// version 16.1
include project_paths.do

***** Clusters for All Pregnancy Episodes - Normal risk and High-risk

///// Clusters for All Trimesters 
use "`out_dir'/MCA_prep_cluster_posthoc", clear
cluster wardslinkage $rate_vars, measure(L2) name(clus_all)

save "`out_dir'/Clusters/cluster_all.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all.dta", clear

cluster dendrogram clus_all, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_allpreg.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(4), name(clus_all) ties(error)
tab cluster, gen(cluster)

sum $rate_vars if cluster != .
sum $rate_vars if cluster == 1
sum $rate_vars if cluster == 2
sum $rate_vars if cluster == 3
sum $rate_vars if cluster == 4

export delimited "`out_dir'/sigtestR/cluster_all.csv", replace


// Post hoc analysis - all trimester
tabstat se_max_alltri_fin, statistics (n mean p50 sd) by(cluster)
tabstat epi_length, statistics (n mean p50 sd) by(cluster)
tabstat ttstart_tri1, statistics (n mean p50 sd) by(cluster)
tabstat ttend_alltri, statistics (n mean p50 sd) by(cluster)
tabstat tt_del, statistics (n mean p50 sd) by(cluster)
tabstat tt_estdel, statistics (n mean p50 sd) by(cluster)
tabstat mm_cnt, statistics (n mean p50 sd) by(cluster)
tabstat ob_cnt, statistics (n mean p50 sd) by(cluster)
tabstat visits_cnt, statistics (n mean p50 sd) by(cluster)
tabstat cci_index, statistics (n median) by(cluster)
tab race_ethn_cat cluster, column

oneway se_max_alltri_fin cluster, tabulate
oneway epi_length cluster, tabulate
oneway ttstart_tri1 cluster, tabulate
oneway ttend_alltri cluster, tabulate
oneway tt_del cluster, tabulate
oneway tt_estdel cluster, tabulate
oneway mm_cnt cluster, tabulate
oneway ob_cnt cluster, tabulate
oneway visits_cnt cluster, tabulate
oneway cci_index cluster, tabulate


// kwallis se_max_alltri_fin, by(cluster)
// kwallis epi_length, by(cluster)
// kwallis ttstart_tri1, by(cluster)
// kwallis ttend_tri1, by(cluster)
// kwallis tt_del, by(cluster)
// kwallis tt_estdel, by(cluster)
kwallis race_ethn_cat, by(cluster)

///// Clusters for Trimester 1
use "`out_dir'/MCA_prep_cluster_posthoc", clear
cluster wardslinkage $rate_vars_tri1, measure(L2) name(clus_all_tri1)

save "`out_dir'/Clusters/cluster_all_tri1.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all_tri1.dta", clear

cluster dendrogram clus_all_tri1, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_allpreg_tri1.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(4), name(clus_all_tri1) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri1 if cluster != .
sum $rate_vars_tri1 if cluster == 1
sum $rate_vars_tri1 if cluster == 2
sum $rate_vars_tri1 if cluster == 3
sum $rate_vars_tri1 if cluster == 4

export delimited "`out_dir'/sigtestR/cluster_all_tri1.csv", replace

// Post hoc analysis - trimester 1 
tabstat se_max_tri1_fin, statistics (n mean p50 sd) by(cluster)
tabstat ttstart_tri1, statistics (n mean p50 sd) by(cluster)
tabstat ttend_tri1, statistics (n mean p50 sd) by(cluster)
tabstat mm_cnt, statistics (n mean p50 sd) by(cluster)
tabstat ob_cnt, statistics (n mean p50 sd) by(cluster)
tabstat visits_cnt, statistics (n mean p50 sd) by(cluster)
tabstat cci_index, statistics (n median) by(cluster)
tab race_ethn_cat cluster, column

oneway se_max_tri1_fin cluster, tabulate
oneway ttstart_tri1 cluster, tabulate
oneway ttend_tri1 cluster, tabulate
oneway mm_cnt cluster, tabulate
oneway ob_cnt cluster, tabulate
oneway visits_cnt cluster, tabulate
oneway cci_index cluster, tabulate

kwallis se_max_tri1_fin, by(cluster)
kwallis ttstart_tri1, by(cluster)
kwallis ttend_tri1, by(cluster)
kwallis race_ethn_cat, by(cluster)

///// Clusters for Trimester 2
use "`out_dir'/MCA_prep_cluster_posthoc", clear
cluster wardslinkage $rate_vars_tri2, measure(L2) name(clus_all_tri2)

save "`out_dir'/Clusters/cluster_all_tri2.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all_tri2.dta", clear

cluster dendrogram clus_all_tri2, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_allpreg_tri2.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(5), name(clus_all_tri2) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri2 if cluster != .
sum $rate_vars_tri2 if cluster == 1
sum $rate_vars_tri2 if cluster == 2
sum $rate_vars_tri2 if cluster == 3
sum $rate_vars_tri2 if cluster == 4
sum $rate_vars_tri2 if cluster == 5

export delimited "`out_dir'/sigtestR/cluster_all_tri2.csv", replace

// Post hoc analysis - trimester 2
tabstat se_max_tri2_fin, statistics (n mean p50 sd) by(cluster)
tabstat ttstart_tri2, statistics (n mean p50 sd) by(cluster)
tabstat ttend_tri2, statistics (n mean p50 sd) by(cluster)
tabstat mm_cnt, statistics (n mean p50 sd) by(cluster)
tabstat ob_cnt, statistics (n mean p50 sd) by(cluster)
tabstat visits_cnt, statistics (n mean p50 sd) by(cluster)
tabstat cci_index, statistics (n median) by(cluster)
tab race_ethn_cat cluster, column

oneway se_max_tri2_fin cluster, tabulate
oneway ttstart_tri2 cluster, tabulate
oneway ttend_tri2 cluster, tabulate
oneway mm_cnt cluster, tabulate
oneway ob_cnt cluster, tabulate
oneway visits_cnt cluster, tabulate
oneway cci_index cluster, tabulate

kwallis se_max_tri2_fin, by(cluster)
kwallis ttstart_tri2, by(cluster)
kwallis ttend_tri2, by(cluster)
kwallis race_ethn_cat, by(cluster)

///// Cluster for Trimester 3
use "`out_dir'/MCA_prep_cluster_posthoc", clear
cluster wardslinkage $rate_vars_tri3, measure(L2) name(clus_all_tri3)

save "`out_dir'/Clusters/cluster_all_tri3.dta", replace

include project_paths.do
use "`out_dir'/Clusters/cluster_all_tri3.dta", clear

cluster dendrogram clus_all_tri3, cutnumber(15) 
graph export "`fig_dir'/clusters_dendogram_allpreg_tri3.pdf", as(pdf) replace

cluster stop, rule(duda)
cluster stop, rule(calinski)

cluster generate cluster = groups(4), name(clus_all_tri3) ties(error)
tab cluster, gen(cluster)

sum $rate_vars_tri3 if cluster != .
sum $rate_vars_tri3 if cluster == 1
sum $rate_vars_tri3 if cluster == 2
sum $rate_vars_tri3 if cluster == 3
sum $rate_vars_tri3 if cluster == 4

export delimited "`out_dir'/sigtestR/cluster_all_tri3.csv", replace

// Post hoc analysis - trimester 3
tabstat se_max_tri3_fin, statistics (n mean p50 sd) by(cluster)
tabstat ttstart_tri3, statistics (n mean p50 sd) by(cluster)
tabstat ttend_tri3, statistics (n mean p50 sd) by(cluster)
tabstat mm_cnt, statistics (n mean p50 sd) by(cluster)
tabstat ob_cnt, statistics (n mean p50 sd) by(cluster)
tabstat visits_cnt, statistics (n mean p50 sd) by(cluster)
tabstat cci_index, statistics (n median) by(cluster)
tab race_ethn_cat cluster, column

oneway se_max_tri3_fin cluster, tabulate
oneway ttstart_tri3 cluster, tabulate
oneway ttend_tri3 cluster, tabulate
oneway mm_cnt cluster, tabulate
oneway ob_cnt cluster, tabulate
oneway visits_cnt cluster, tabulate
oneway cci_index cluster, tabulate

kwallis se_max_tri3_fin, by(cluster)
kwallis ttstart_tri3, by(cluster)
kwallis ttend_tri3, by(cluster)
kwallis race_ethn_cat, by(cluster)
