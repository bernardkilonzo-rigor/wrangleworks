setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Boolean operations and logical functions")
#load libraries
library(tidyverse)

#load data
superstore<-read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")

#logical functions
#CASE  function
#using case function to classify profit as (Profitable, Unprofitable, or Zero)

superstore<-superstore%>%
  mutate(class =case_when(
  Profit>0 ~ "Profitable",
  Profit<0 ~ "Unprofitable",
  TRUE ~ "Zero"
))

#computing orders by class


#IF_ELSE function
#using if-else  function to classify profit as (unprofitable, profitable, highly profitable and super profitable)

superstore<-superstore%>%
  mutate(class_cal =
           if_else(Profit >= 1000, "Super  Profitable",
           if_else(Profit >= 150, "Highly Profitable",
           if_else(Profit >= 0, "Profitable",
           if_else(is.na(Profit), "Missing","Unprofitable"
  )))))

# computing orders by new class


# IIF


# AND



# OR


# IFNULL



# ISDATE


# ISNULL


# IN


# ZN
