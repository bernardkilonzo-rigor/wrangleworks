setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Data shaping and transformation")
#load libraries
library(tidyverse)
library(janitor)
library(data.table)
library(tidyr)

#load data sets
superstore <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")%>%
  clean_names()
Financial_data <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/refs/heads/main/data/Financial%20Data.csv", check.names = FALSE)

#shaping data
#1. pivot longer
Financial_data_longpvt <- Financial_data%>%
  pivot_longer(cols = "01/01/2024":"01/12/2025", names_to = "Date", values_to = "Values")

#or
Financial_data_log <- Financial_data%>%
  pivot_longer(cols = contains("/"), names_to = "Date", values_to = "Value")

# using data.table (best for larger data sets)
dt_wd <- as.data.table(Finacial_data)
dt_long <- dt_wd %>%
  melt(
  id.vars = "Indicator Name",
  measure.vars = c("01/01/2024","01/12/2025"),
  variable.name = "Date",
  value.name = "Value"
)

#2. pivot wider
# using dplyr package
Financial_wider <- Financial_data_log%>%
  pivot_wider(names_from = Date, values_from = Value)

# using data.table  (best for large data sets)
dt <- as.data.table(Financial_data_log)
dt_wide <- dcast(
  dt,
  `Indicator Name` ~ Date,
  value.var = "Value"
)

#transposing data (Financial_data above)
dt_t <- Financial_data %>%
  pivot_longer(
    cols = -`Indicator Name`,
    names_to = "Date",
    values_to = "Value"
  ) %>%
  pivot_wider(
    names_from = `Indicator Name`,
    values_from = Value
  )
