setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Survey data")

#load libraries
library(tidyverse)
library(janitor) #for cleaning names
library(survey) #core survey analysis
library(skimr) #for quick data summaries

#load data set
survey_data <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/refs/heads/main/data/Survey_Data_Raw.csv")

#inspecting data structure
glimpse(survey_data)
skim(survey_data)

