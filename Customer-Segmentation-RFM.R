###########################################
# Customer Segmentation using RFM Analysis - Recency Frequency Monetry
#
# Reference - https://www.kaggle.com/hendraherviawan/customer-segmentation-using-rfm-analysis-r
# Reference - https://github.com/rsquaredacademy/rfm
#
###########################################

#################################################################################################################################
#install.packages("rfm")
#install.packages("Tydyverse")
library(rfm)

library(data.table)
library(dplyr)
library(ggplot2)
#library(stringr)
#library(DT)
library(tidyr)
library(tidyverse)
library(knitr)
library(rmarkdown)


#########################
########Data Load
#########################
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
setwd('/u01/tbc')
df_data <- fread('data.csv')

summary(df_data)

#Basic overview of loaded data
summary(df_data)

#########################
###Data Cleaning
#########################
df_data <- df_data %>% 
  mutate(Quantity = replace(Quantity, Quantity<=0, NA),
         UnitPrice = replace(UnitPrice, UnitPrice<=0, NA))

df_data <- df_data %>%
  drop_na()

#See Summary of data after data cleaning
summary(df_data)
head(df_data)
tail(df_data)

#############
## Recode columns
############
df_data <- df_data %>% 
  mutate(InvoiceNo=as.factor(InvoiceNo), StockCode=as.factor(StockCode), 
         InvoiceDate=as.Date(InvoiceDate, '%m/%d/%y'), CustomerID=as.factor(CustomerID), 
         Country=as.factor(Country))

df_data <- df_data %>% 
  mutate(total_dolar = Quantity*UnitPrice)

summary(df_data)
tail(df_data)
min(df_data$InvoiceDate)
max(df_data$InvoiceDate)

### Calculate RFM 
analysis_date <- lubridate::as_date('2011-12-09', tz = 'UTC')

rfm_result <- rfm_table_order(data = df_data, customer_id = CustomerID, order_date = InvoiceDate, revenue = total_dolar, analysis_date = analysis_date)
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