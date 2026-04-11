setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Survey data")

#load libraries
library(tidyverse)
library(janitor) #for cleaning names
library(survey) #core survey analysis
library(skimr) #for quick data summaries
library(labelled) #for variable labels
library(naniar) #for manipulating missing data

#load data set
survey_data <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/refs/heads/main/data/Survey_Data_Raw.csv")%>%
  clean_names() #converts names to snake case.

#inspecting data structure
glimpse(survey_data)
skim(survey_data)

#explore missing data
vis_miss(survey_data)
miss_var_summary(survey_data)
gg_miss_var(survey_data)
gg_miss_case(survey_data)

#cleaning and preparing variables
#recode numeric likert values to  text labels

likert_labels <- c(
  `1` = "Highly dissatisfied",
  `2` = "Dissatisfied",
  `3` = "Neutral",
  `4` = "Satisfied",
  `5` = "Highly satisfied"
)

survey_data <- survey_data%>%
  mutate(across(q3a:q4g, ~recode(.x, !!!likert_labels)))

#exploratory data analysis (EDA)


#
