setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Data shaping and transformation")
#load libraries
library(tidyverse)
library(janitor)

#load data set
superstore <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")%>%
  clean_names()
