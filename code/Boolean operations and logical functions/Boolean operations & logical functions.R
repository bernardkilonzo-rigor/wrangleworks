setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Boolean operations and logical functions")
#load libraries
library(tidyverse)

#load data
superstore<-read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")
view(superstore)
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

# IF & AND

superstore<-superstore%>%
  mutate(if_and = 
           if_else(class == "Profitable" & Sales > 1000, "Green Light",
           if_else(class == "Unprofitable" & Sales > 1000, "Red Light",
           if_else(class == "Zero" & Sales >1000, "Yellow Light", "Others"
  ))))

superstore%>%group_by(if_and)%>%
  summarise(n = n_distinct(Row.ID))

# IF & OR

superstore<-superstore%>%
  mutate(if_or = 
           if_else(Profit > 1000 | Sales > 1000, "High Value","Others"))

superstore%>%group_by(if_or)%>%
  summarise(n = n_distinct(Row.ID))

#IN (%in%)

superstore<-superstore%>%
  mutate(New_Region =
           if_else(Region %in% c("South","Central"), "Coastal Region",
                   Region))

superstore%>%group_by(New_Region)%>%
  summarise(n =n_distinct(Row.ID))




