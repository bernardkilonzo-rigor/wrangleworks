setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Data shaping and transformation")
#load libraries
library(tidyverse)
library(janitor)

#load data sets
superstore <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")%>%
  clean_names()
Financial_data <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/refs/heads/main/data/Financial%20Data.csv", check.names = FALSE)

#shaping data
#pivot longer
Financial_data_longpvt <- Financial_data%>%
  pivot_longer(cols = "01/01/2024":"01/12/2025", names_to = "Date", values_to = "Values")

#or
Financial_data_log <- Financial_data%>%
  pivot_longer(cols = contains("/"), names_to = "Date", values_to = "Value")


