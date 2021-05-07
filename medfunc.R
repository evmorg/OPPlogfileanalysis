#work directory
getwd()
setwd("/Users/evan/Desktop/Thesis/Data_Final/medfunc")
#load libs
library(readr)
library(PMCMRplus)
library(dplyr)
library(ggplot2)
#load data
medfunc<- read_csv("medfunc.csv", col_names = TRUE)
medfunc_norm <- read_csv("medfunc_norm.csv", col_names = TRUE)
medfunc_high <- read_csv("medfunc_high.csv", col_names = TRUE)
medfunc_tri1 <- read_csv("medfunc_tri1.csv", col_names = TRUE)
medfunc_tri2 <- read_csv("medfunc_tri2.csv", col_names = TRUE)
medfunc_tri3 <- read_csv("medfunc_tri3.csv", col_names = TRUE)
# change x-axis
medfunc$preg_tri <- as.factor(medfunc$preg_tri)
medfunc_norm$preg_tri <- as.factor(medfunc_norm$preg_tri)
medfunc_high$preg_tri <- as.factor(medfunc_high$preg_tri)
medfunc_tri1$preg_tri <- as.factor(medfunc_tri1$preg_tri)
medfunc_tri2$preg_tri <- as.factor(medfunc_tri2$preg_tri)
medfunc_tri3$preg_tri <- as.factor(medfunc_tri3$preg_tri)
#re-order legend
medfunc$risk <- factor(medfunc$risk, levels = c("Normal","High-Risk"))
medfunc_norm$risk <- factor(medfunc_norm$risk, levels = c("Normal","High-Risk"))
medfunc_high$risk <- factor(medfunc_high$risk, levels = c("Normal","High-Risk"))
medfunc_tri1$risk <- factor(medfunc_tri1$risk, levels = c("Normal","High-Risk"))
medfunc_tri2$risk <- factor(medfunc_tri2$risk, levels = c("Normal","High-Risk"))
medfunc_tri3$risk <- factor(medfunc_tri3$risk, levels = c("Normal","High-Risk"))

## START ALL PREG, ALL FUNC
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR_tri, 
)) + labs(title = "All Function Use per Trimester - All Pregnancies", x = "Trimester", y = "Sessions with Function Use") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15)) 
# medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d,
               col = "#A4B68B",
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               shape = 21,
               fill = "#A4B68B")
ggsave("medfunc_all.png")

##START ALL PREG, ALL FUNC, NORM V HIGH
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "All Function Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_all_risk.png")

##START ALL PREG, MESSAGING, NORM V HIGH
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR1_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "Messaging Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(legend.position="none") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_messaging.png")

##START ALL PREG, VISITS, NORM V HIGH
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR2_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "Visits Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(legend.position="none") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_visits.png")

##START ALL PREG, MYRECORD, NORM V HIGH
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR3_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "MyRecord Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(legend.position="none") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_myrecord.png")

##START ALL PREG, BILLING, NORM V HIGH
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR5_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "Billing Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(legend.position="none") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_billing.png")


##START ALL PREG, BILLING, NORM V HIGH NO LEGEND
# I will define a dodge and jitterdodge object to avoid overlapping data points 
# or stats that we will overlay later
posn.d <- position_dodge(width=0.2)
posn.jd <- position_jitterdodge(jitter.width = 0.1, dodge.width=0.2)
medfunc_plot <- ggplot(medfunc, aes(x=preg_tri, y=sum_GR5_tri, col=risk, fill=risk, 
                                    group=risk)) + labs(title = "Billing Use per Trimester", x = "Trimester", y = "Sessions with Function Use", fill = "Pregnancy Risk Group", color = "Pregnancy Risk Group") + theme(axis.text = element_text(size = 15), axis.title = element_text(size=15), plot.title = element_text(size = 17), legend.text = element_text(size = 15), legend.title = element_text(size = 15))
medfunc_plot + geom_point(position = posn.jd)
# Function for median and IQR
median_IQR <- function(x) {
  data.frame(y = median(x), # Median
             ymin = quantile(x)[2], # 1st quartile
             ymax = quantile(x)[4])  # 3rd quartile
}
# Function for min, max values
range <- function(x) {
  data.frame(ymin=min(x),
             ymax=max(x))
}
# Updated plot
medfunc_plot + 
  stat_summary(geom = "linerange",
               fun.data = median_IQR, 
               position = posn.d, 
               size=2) + 
  # stat_summary(geom = "linerange", 
  #              fun.data = range, 
  #              position = posn.d, 
  #              size=3, 
  #              alpha=0.5)+ 
  stat_summary(geom = "point", 
               fun.y = "median", 
               position = posn.d, 
               size = 4, 
               col = "black", 
               shape = 21)
ggsave("medfunc_billing2.png")
