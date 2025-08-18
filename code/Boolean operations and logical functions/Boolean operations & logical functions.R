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

# IF_ELSE


# IIF


# AND



# OR


# IFNULL



# ISDATE


# ISNULL


# IN


# ZN
