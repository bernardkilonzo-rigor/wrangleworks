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
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    "Highest Qualifications" = highest_qualifications,
    Count = n,
    Percent = percent
  )%>%
  gt()

#employment frequency
survey_data%>%
  tabyl(employment_status)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    "Employment Status" = employment_status,
    Count = n,
    Percent = percent
  )%>%
  gt()

#income level frequency
survey_data%>%
  tabyl(income_level)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    "Income Level" = income_level,
    Count = n,
    Percent = percent
  )%>%
  gt()

#country frequency
survey_data%>%
  tabyl(country)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    Country = country,
    Count = n,
    Percent = percent
  )%>%
  gt()

#computing frequency tables (dplyr)
#gender frequency table
survey_data%>%
  group_by(gender)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    gender = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    Gender = gender
  )%>%
  gt()

#age_group frequency table
survey_data%>%
  group_by(age_group)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    age_group = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    "Age Group" = age_group
  )%>%
  gt()

#qualifications frequency table
survey_data%>%
  group_by(highest_qualifications)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    highest_qualifications = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    "Highest Qualifications" = highest_qualifications
  )%>%
  gt()

#employment frequency table
survey_data%>%
  group_by(employment_status)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    employment_status = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    "Employment Status" = employment_status
  )%>%
  gt()

#income level frequency table
survey_data%>%
  group_by(income_level)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    income_level = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    "Income Level" = income_level
  )%>%
  gt()

#country frequency table
survey_data%>%
  group_by(country)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    country = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    Country = country
  )%>%
  gt()

#cross-tab analysis
#a simple cross tab analysis
#using janitor
#computing count
survey_data%>%
  tabyl(gender,q3a)%>%
  rename(
    Gender = gender
  )%>%gt()

#computing percentages
survey_data%>%
  tabyl(gender,q3a)%>%
  adorn_percentages()%>%
  adorn_pct_formatting()%>%
  rename(
    Gender = gender
  )%>%gt()

#using dplyr
survey_data%>%
  count(gender, q3a)%>%
  group_by(gender)%>%
  mutate(
    pct = n/sum(n)
  )%>%
  mutate(pct = scales::percent(pct, accuracy =0.1))

#pivoting q3a:q3e (cross tab to columnar format)
dat_long_q3<- survey_data%>%
  select(respondent_s_id,gender,age_group,highest_qualifications,
         employment_status,income_level,country,q3a:q3e)%>%
  pivot_longer(q3a:q3e, names_to = "Quiz", values_to = "Ratings")

#analyzing rating scale (q3)
#computing count
dat_long_q3%>%
  tabyl(Quiz, Ratings)%>%
  gt()

#computing percentages
dat_long_q3%>%
  tabyl(Quiz, Ratings)%>%
  adorn_percentages()%>%
  adorn_pct_formatting()%>%
  gt()

#pivoting q4a:q4g (cross tab to columnar format)
dat_long_q4<- survey_data%>%
  select(respondent_s_id,gender,age_group,highest_qualifications,
         employment_status,income_level,country,q4a:q4g)%>%
  pivot_longer(q4a:q4g, names_to = "Quiz", values_to = "Ratings")

#analyzing rating scale (q4)
#computing count
dat_long_q4%>%
  tabyl(Quiz, Ratings)%>%
  gt()

#computing percentages
dat_long_q4%>%
  tabyl(Quiz, Ratings)%>%
  adorn_percentages()%>%
  adorn_pct_formatting()%>%
  gt()

#analyzing YES/NO questions
#pivoting q2a:q2e (cross tab to columnar format)
dat_long_q2<- survey_data%>%
  select(respondent_s_id,gender,age_group,highest_qualifications,
         employment_status,income_level,country,q2a:q2e)%>%
  pivot_longer(q2a:q2e, names_to = "Quiz", values_to = "Response")

#computing count
dat_long_q2%>%
  tabyl(Quiz, Response)%>%
  gt()

#computing percent
dat_long_q2%>%
  tabyl(Quiz, Response)%>%
  adorn_percentages()%>%
  adorn_pct_formatting()%>%
  gt()

#single response questions
#using janitor
survey_data%>%
  tabyl(q1)%>%
  arrange(desc(n))%>% #sorting before totals
  adorn_totals("row")%>% #add total
  adorn_pct_formatting()%>% #add percentages
  rename(
    "Info Source" = q1,
    Count = n,
    Percent = percent
  )%>%
  gt()

#using dplyr
survey_data%>%
  group_by(q1)%>%
  summarise(Count = n())%>% #compute frequency
  mutate(Percent = Count/sum(Count))%>% #compute percentages
  arrange(desc(Count))%>% #sort in descending
  add_row(
    q1 = "Total",
    Count = sum(.$Count),
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  rename(
    "Info Source" = q1
  )%>%
  gt()

#dealing with multiple response questions
#using dplyr package
#converting wide to long data format
dat_long<- survey_data%>%
  select(respondent_s_id,q5_1:q5_6)%>%
  pivot_longer(q5_1:q5_6, names_to = "Quiz", values_to = "Response")

total_unique <- dat_long %>%
  filter(Response != "") %>%
  summarise(Total = n_distinct(respondent_s_id)) %>%
  pull(Total)

dat_long%>%
  filter(Response != "")%>%
  group_by(Response)%>%
  summarise(Count = n_distinct(respondent_s_id))%>%
  mutate(Percent = Count/total_unique)%>%
  arrange(desc(Count))%>%
  add_row(
    Response = "Total",
    Count = total_unique,
    Percent = 1
  )%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  gt()

#using janitor
dat_long %>%
  filter(Response != "")%>%
  tabyl(Response)%>%
  arrange(desc(n))%>%
  bind_rows(
    tibble(
      Response = "Total", n = total_unique
    )
  )%>%
  mutate(percent = n/total_unique)%>%
  mutate(percent = scales::percent(percent, accuracy =0.1))%>%
  rename(
    Count = n,
    Percent = percent
  )%>%
  gt()

#computing Net Promoters Score (NPS)
#converting wide to long data format (pivoting q6a to q6e)
dat_long_q6<- survey_data%>%
  select(respondent_s_id,gender,age_group,highest_qualifications,
         employment_status,income_level,country,q6a:q6e)%>%
  pivot_longer(q6a:q6e, names_to = "Quiz", values_to = "Rating")

#computing net promoters score (NPS) using janitor
dat_long_q6%>%
  mutate(
    nps_group = 
      case_when(
        Rating >= 9 ~ "Promoters",
        Rating >= 7 ~ "Passive",
        TRUE ~ "Detractors"
      )
  )%>%
  tabyl(Quiz,nps_group)%>%
  adorn_percentages()%>%
  adorn_pct_formatting()%>%
  gt()

#computing Net Promoters Score (NPS) with dplyr
dat_long_q6%>%
  mutate(
    nps_group = 
      case_when(
        Rating >= 9 ~ "Promoters",
        Rating >= 7 ~ "Passive",
        TRUE ~ "Detractors"
      )
  )%>%
  group_by(Quiz, nps_group)%>%
  summarise(Count = n_distinct(respondent_s_id),
            .groups = "drop")%>%
  mutate(Percent = Count/sum(Count))%>%
  mutate(Percent = scales::percent(Percent, accuracy =0.1))%>%
  select(Quiz, nps_group, Percent)%>%
  pivot_wider(
    names_from = nps_group,
    values_from = Percent
  )%>%gt()
