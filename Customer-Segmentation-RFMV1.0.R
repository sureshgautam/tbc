###########################################
# Customer Segmentation using RFM Analysis - Recency Frequency Monetry
#
# Reference - https://www.kaggle.com/hendraherviawan/customer-segmentation-using-rfm-analysis-r
# Reference - https://github.com/rsquaredacademy/rfm
#
###########################################

#################################################################################################################################
#install.packages("rfm")
library(rfm)

library(data.table)
library(dplyr)
library(ggplot2)
library(tidyr)
library(knitr)
library(rmarkdown)


#########################
########Data Load
#########################
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd('/u01/tbc')
df_data <- fread('sample-orders.csv')

summary(df_data)

#Basic overview of loaded data
summary(df_data)

#########################
###Data Cleaning
#########################

#See Summary of data after data cleaning
summary(df_data)
head(df_data)
tail(df_data)

#############
## Recode columns
############
df_data <- df_data %>% 
  mutate(order_id=as.factor(order_id),
         order_date=as.Date(order_date, '%m/%d/%y'), customer=as.factor(customer))


summary(df_data)
tail(df_data)
min(df_data$order_date)
max(df_data$order_date)

### Calculate RFM 
analysis_date <- lubridate::as_date(max(df_data$order_date), tz = 'UTC')

rfm_result <- rfm_table_order(data = df_data, customer_id = customer, order_date = order_date, revenue = grand_total, analysis_date = analysis_date)
print(class(rfm_result))

#Deplicated some features
#rfm_result_df <- as_data_frame(rfm_result)
summary(rfm_result)
print(rfm_result)

##### 
#### Data Visualization - More to cover when we read about EDA(Explotry Data Analysis)
rfm_heatmap(rfm_result)
rfm_bar_chart(rfm_result)
rfm_histograms(rfm_result)
rfm_order_dist(rfm_result)
rfm_rm_plot(rfm_result)
rfm_fm_plot(rfm_result)
rfm_rf_plot(rfm_result)

# RFM Analysis End here
###################################################
###########################################
# Customer Segmentation using RFM Analysis - Recency Frequency Monetry
#
# Reference - https://www.kaggle.com/hendraherviawan/customer-segmentation-using-rfm-analysis-r
# Reference - https://github.com/rsquaredacademy/rfm
#
###########################################