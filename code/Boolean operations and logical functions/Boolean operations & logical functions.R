#load libraries
library(tidyverse)

#load data set
superstore<-read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")
view(superstore)
#boolean operations & logical functions
#1 CASE function
#using case function to categorize profit as (Profitable, Unprofitable, or Zero)

superstore<-superstore%>%
  mutate(class =case_when(
  Profit>0 ~ "Profitable",
  Profit<0 ~ "Unprofitable",
  TRUE ~ "Zero"
))

#2 IF_ELSE function
#using if-else function to categorize profit as (unprofitable, profitable, highly profitable and super profitable)

superstore<-superstore%>%
  mutate(class_cal =
           if_else(Profit >= 1000, "Super Profitable",
           if_else(Profit >= 150, "Highly Profitable",
           if_else(Profit >= 0, "Profitable",
           if_else(is.na(Profit), "Missing","Unprofitable"
  )))))

#3 IF AND function
#using IF AND function to categorize orders based on Profit and Sales values.
superstore<-superstore%>%
  mutate(if_and = 
           if_else(class == "Profitable" & Sales > 1000, "Green Light",
           if_else(class == "Unprofitable" & Sales > 1000, "Red Light",
           if_else(class == "Zero" & Sales >1000, "Yellow Light", "Others"
  ))))

#4 IF OR functions
#using IF OR function to categorize orders based on Profit and Sales values. 

superstore<-superstore%>%
  mutate(if_or = 
           if_else(Profit > 1000 | Sales > 1000, "High Value","Others"))

#5 IN (%in%)
#using %in% function to group the South and Central regions into a new region called "Coastal Region"
superstore<-superstore%>%
  mutate(New_Region =
           if_else(Region %in% c("South","Central"), "Coastal Region",
                   Region))




