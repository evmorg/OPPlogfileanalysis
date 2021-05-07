getwd()
setwd("/Users/evan/Desktop/Thesis/Data_Final/medfunc")

library(readr)
library(PMCMRplus)
library(dplyr)
library(ggpubr)


medfunc <- read_csv("medfunc.csv", col_names = TRUE)
medfunc_norm <- read_csv("medfunc_norm.csv", col_names = TRUE)
medfunc_high <- read_csv("medfunc_high.csv", col_names = TRUE)
medfunc_tri1 <- read_csv("medfunc_tri1.csv", col_names = TRUE)
medfunc_tri2 <- read_csv("medfunc_tri2.csv", col_names = TRUE)
medfunc_tri3 <- read_csv("medfunc_tri3.csv", col_names = TRUE)

#####All Functions
#all preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR_tri ~ preg_tri, data = medfunc)
#all preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc$sum_GR_tri, medfunc$preg_tri,
                     p.adjust.method = "bonferroni")

#norm preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR_tri ~ preg_tri, data = medfunc_norm)
#norm preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_norm$sum_GR_tri, medfunc_norm$preg_tri,
                     p.adjust.method = "bonferroni")

#high preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR_tri ~ preg_tri, data = medfunc_high)
#high preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_high$sum_GR_tri, medfunc_high$preg_tri,
                     p.adjust.method = "bonferroni")

#all preg, all func, tri1 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri1$sum_GR_tri, medfunc_tri1$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri2 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri2$sum_GR_tri, medfunc_tri2$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri3 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri3$sum_GR_tri, medfunc_tri3$risk,
                     p.adjust.method = "bonferroni")


#####Messaging
#norm preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR1_tri ~ preg_tri, data = medfunc_norm)
#norm preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_norm$sum_GR1_tri, medfunc_norm$preg_tri,
                     p.adjust.method = "bonferroni")

#high preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR1_tri ~ preg_tri, data = medfunc_high)
#high preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_high$sum_GR1_tri, medfunc_high$preg_tri,
                     p.adjust.method = "bonferroni")

#all preg, all func, tri1 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri1$sum_GR1_tri, medfunc_tri1$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri2 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri2$sum_GR1_tri, medfunc_tri2$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri3 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri3$sum_GR1_tri, medfunc_tri3$risk,
                     p.adjust.method = "bonferroni")



#####Visits
#norm preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR2_tri ~ preg_tri, data = medfunc_norm)
#norm preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_norm$sum_GR2_tri, medfunc_norm$preg_tri,
                     p.adjust.method = "bonferroni")

#high preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR2_tri ~ preg_tri, data = medfunc_high)
#high preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_high$sum_GR2_tri, medfunc_high$preg_tri,
                     p.adjust.method = "bonferroni")

#all preg, all func, tri1 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri1$sum_GR2_tri, medfunc_tri1$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri2 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri2$sum_GR2_tri, medfunc_tri2$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri3 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri3$sum_GR2_tri, medfunc_tri3$risk,
                     p.adjust.method = "bonferroni")



#####MyRecord
#norm preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR3_tri ~ preg_tri, data = medfunc_norm)
#norm preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_norm$sum_GR3_tri, medfunc_norm$preg_tri,
                     p.adjust.method = "bonferroni")

#high preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR3_tri ~ preg_tri, data = medfunc_high)
#high preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_high$sum_GR3_tri, medfunc_high$preg_tri,
                     p.adjust.method = "bonferroni")

#all preg, all func, tri1 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri1$sum_GR3_tri, medfunc_tri1$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri2 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri2$sum_GR3_tri, medfunc_tri2$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri3 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri3$sum_GR3_tri, medfunc_tri3$risk,
                     p.adjust.method = "bonferroni")



#####Billing
#norm preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR5_tri ~ preg_tri, data = medfunc_norm)
#norm preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_norm$sum_GR5_tri, medfunc_norm$preg_tri,
                     p.adjust.method = "bonferroni")

#high preg, all func, all tri - diffs across all tri
kruskal.test(sum_GR5_tri ~ preg_tri, data = medfunc_high)
#high preg, all func, all tri - diffs between tri
pairwise.wilcox.test(medfunc_high$sum_GR5_tri, medfunc_high$preg_tri,
                     p.adjust.method = "bonferroni")

#all preg, all func, tri1 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri1$sum_GR5_tri, medfunc_tri1$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri2 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri2$sum_GR5_tri, medfunc_tri2$risk,
                     p.adjust.method = "bonferroni")
#all preg, all func, tri3 - diffs between risk groups
pairwise.wilcox.test(medfunc_tri3$sum_GR5_tri, medfunc_tri3$risk,
                     p.adjust.method = "bonferroni")