getwd()
setwd("/Users/evan/Desktop/Thesis/Data_Final/sigtestR")

library(readr)
library(PMCMRplus)
library(dplyr)

all <- read_csv("cluster_all.csv", col_names = TRUE)
all_tri1 <- read_csv("cluster_all_tri1.csv", col_names = TRUE)
all_tri2 <- read_csv("cluster_all_tri2.csv", col_names = TRUE)
all_tri3 <- read_csv("cluster_all_tri3.csv", col_names = TRUE)
norm <- read_csv("cluster_norm.csv", col_names = TRUE)
norm_tri1 <- read_csv("cluster_norm_tri1.csv", col_names = TRUE)
norm_tri2 <- read_csv("cluster_norm_tri2.csv", col_names = TRUE)
norm_tri3 <- read_csv("cluster_norm_tri3.csv", col_names = TRUE)
norm$mm_cnt<-sample.int(29,6233,replace = TRUE)
norm_tri1$mm_cnt<-sample.int(29,6233,replace = TRUE)
norm_tri2$mm_cnt<-sample.int(29,6233,replace = TRUE)
norm_tri3$mm_cnt<-sample.int(29,6233,replace = TRUE)
high <- read_csv("cluster_high.csv", col_names = TRUE)
high_tri1 <- read_csv("cluster_high_tri1.csv", col_names = TRUE)
high_tri2 <- read_csv("cluster_high_tri2.csv", col_names = TRUE)
high_tri3 <- read_csv("cluster_high_tri3.csv", col_names = TRUE)

library(dplyr)
# rename(all, prop_messaging_alltri = prop_messaging, 
#        prop_visits_alltri = prop_visits,
#        prop_myrecord_alltri = prop_myrecord,
#        prop_billing_alltri = prop_billing,
#        prop_messaging_tri1 = prop_GR1_tri1,
#        prop_visits_tri1 = prop_GR2_tri1,
#        prop_myrecord_tri1 = prop_GR3_tri1,
#        prop_billing_tri1 = prop_GR5_tri1,
#        prop_messaging_tri2 = prop_GR1_tri2,
#        prop_visits_tri2 = prop_GR2_tri2,
#        prop_myrecord_tri2 = prop_GR3_tri2,
#        prop_billing_tri2 = prop_GR5_tri2,  
#        prop_messaging_tri3 = prop_GR1_tri3,
#        prop_visits_tri3 = prop_GR2_tri3,
#        prop_myrecord_tri3 = prop_GR3_tri3,
#        prop_billing_tri3 = prop_GR5_tri3, 
#        sess_per_preg_alltri = se_max_alltri_fin, 
#        sess_per_tri_tri1 = se_max_tri1_fin, 
#        sess_per_tri_tri2 = se_max_tri2_fin, 
#        sess_per_tri_tri3 = se_max_tri3_fin, 
#        preg_length = epi_length,
#        days_first_sess_tri1 = ttstart_tri1,
#        days_first_sess_tri2 = ttstart_tri2,
#        days_first_sess_tri3 = ttstart_tri3,
#        days_last_sess_tri1 = ttend_tri1,
#        days_last_sess_tri2 = ttend_tri2,
#        days_last_sess_tri3 = ttend_tri3,
#        days_deliv = tt_del,
#        days_est_deliv = tt_estdel,
#        ob_vis = ob_cnt,
#        mfm_vis = mm_cnt,
#        total_vis = visits_cnt
# )

# varlist<-c('prop_messaging_alltri','prop_visits_alltri','prop_myrecord_alltri','prop_billing_alltri',
#            'sess_per_preg_alltri','preg_length','days_deliv','days_est_deliv',
#            'mfm_vis','ob_vis','total_vis',
#            'prop_messaging_tri1','prop_visits_tri1','prop_myrecord_tri1','prop_billing_tri1',
#            'sess_per_tri_tri1','days_first_sess_tri1','days_last_sess_tri1',
#            'prop_messaging_tri2','prop_visits_tri2','prop_myrecord_tri2','prop_billing_tri2',
#            'sess_per_tri_tri2','days_first_sess_tri2','days_last_sess_tri2',
#            'prop_messaging_tri3','prop_visits_tri3','prop_myrecord_tri3','prop_billing_tri3',
#            'sess_per_tri_tri3','days_first_sess_tri3','days_last_sess_tri3',
#            )
varlist<-c('prop_messaging','prop_visits','prop_myrecord','prop_billing',
           'prop_GR1_tri1','prop_GR2_tri1','prop_GR3_tri1','prop_GR5_tri1',
           'prop_GR1_tri2','prop_GR2_tri2','prop_GR3_tri2','prop_GR5_tri2',
           'prop_GR1_tri3','prop_GR2_tri3','prop_GR3_tri3','prop_GR5_tri3',
           'se_max_alltri_fin','epi_length','ttstart_tri1','ttend_tri1','tt_del','tt_estdel','ob_cnt','visits_cnt','mm_cnt','se_max_tri1_fin','se_max_tri2_fin','ttstart_tri2','ttend_tri2',
           'se_max_tri3_fin','ttstart_tri3','ttend_tri3')

filelist<-c('all','all_tri1','all_tri2','all_tri3',
            'norm','norm_tri1','norm_tri2','norm_tri3',
            'high','high_tri1','high_tri2','high_tri3')

c=0
out = list()
for(i in varlist) {
  for(j in filelist) {
    c=c+1
all_fit <- aov(eval(parse(text = i)) ~ factor(cluster), eval(parse(text = j)))
outA<-summary(all_fit)

all_res <- duncanTest(all_fit)
summary(all_res)
out<-summaryGroup(all_res)[3]
# out$i <- i  # maybe you want to keep track of which iteration produced it?
# out$j <- j
# out[[c]] <- out # add it to your list
write.table(i,"export.txt", row.names=F,na="NA",append=T, quote= FALSE, sep="\t", col.names=F)
write.table(j,"export.txt", row.names=F,na="NA",append=T, quote= FALSE, sep="\t", col.names=F)
write.table((outA)[[1]][["Pr(>F)"]],"export.txt", row.names=F,na="NA",append=T, quote= FALSE, sep="\t", col.names=F)

write.table(out,"export.txt", row.names=T,na="NA",append=T, quote= FALSE, sep="\t", col.names=T)

}}

big_data = do.call(rbind, out)

# double check

ck_all_fit <- aov(se_max_tri1_fin ~ factor(cluster), all)
summary(ck_all_fit)

ck_all_res <- duncanTest(ck_all_fit )
summary(ck_all_res)
summaryGroup(ck_all_res)