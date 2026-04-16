setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Survey data")

#load libraries
library(tidyverse)
library(janitor) #for cleaning names
library(survey) #core survey analysis
library(skimr) #for quick data summaries
library(labelled) #for variable labels
library(naniar) #for manipulating missing data
library(gt)

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

#computing frequency tables (tidyverse + janitor)
#gender frequency
survey_data%>%
  tabyl(gender)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    Gender = gender,
    Count = n,
    Percent = percent
  )%>%
  gt()

#age_group frequency
survey_data%>%
  tabyl(age_group)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    "Age Group" = age_group,
    Count = n,
    Percent = percent
  )%>%
  gt()

#qualifications frequency
survey_data%>%
  tabyl(highest_qualifications)%>%
  adorn_pct_formatting()%>% #add percentages
  adorn_totals("row")%>% #add total
  gt()

#employment frequency
survey_data%>%
  tabyl(employment_status)%>%
  adorn_pct_formatting()%>% #add percentages
  adorn_totals("row")%>% #add total
  gt()

#income level frequency
survey_data%>%
  tabyl(income_level)%>%
  adorn_pct_formatting()%>% #add percentages
  adorn_totals("row")%>% #add total
  gt()

#country frequency
survey_data%>%
  tabyl(country)%>%
  adorn_pct_formatting()%>% #add percentages
  adorn_totals("row")%>% #add total
  gt()

#cross-tab analysis
var_to_tab <-c("q3a","q3b","q3c","q3d","q3e")

crosstabs <- var_to_tab %>%
  map(~ survey_data %>%
    tabyl(gender, !!sym(.x))%>%
    adorn_totals(c("row", "col"))%>%
    adorn_percentages("row")%>%
    adorn_pct_formatting(digits = 1)
    )

names(crosstabs)<- var_to_tab
crosstabs
