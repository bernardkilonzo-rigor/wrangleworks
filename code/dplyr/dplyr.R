setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\dplyr")

#load dplyr library
library(dplyr)

#load data set
superstore <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")

#1. filter_out() function
df <- tibble(
  name = c("Ann","Ken","Jack", "Anita", "Alex", "Walter", "Ruth", "Lucy"),
  Status = c("Present", "Absent", "Absent", "Present","Absent","Present","Present", "Absent"),
  Amount = c(1000,867,1200,890,3400,1234,600,340)
)
#using filter() to drop records where status "present" and Amount>=1000
df%>%filter(!(Status=="Present" & Amount>=1000))

#using filter_out() to drop records where status "present" and Amount>=1000
df%>%filter_out(Status=="Present", Amount>=1000)

#2. recode_values() function
dat <- tibble(
  rating = c(1,4,5,2,3,4,4,5,1,2,3,3,5,4)
)

#recode values using case_when()
dat %>%mutate(
  rating_nam = case_when(
    rating ==1 ~ "Strongly Disagree",
    rating ==2 ~ "Disagree",
    rating ==3 ~ "Neutral",
    rating ==4 ~ "Agree",
    rating ==5 ~ "Strongly Agree"
  )
)

#recode values using if_else()
dat %>%
  mutate(rating_name = 
           if_else(rating ==1, "Strongly Disagree",
                   if_else(rating ==2, "Disagree",
                           if_else(rating ==3, "Neutral",
                                   if_else(rating ==4, "Agree",
                                           if_else(rating ==5, "Strongly Agree", "")))))
  )
#better approach with recode_values()
dat%>%
  mutate(
    rating_name_1 = rating%>%
      recode_values(
        1 ~ "Strongly Disagree",
        2 ~ "Disagree",
        3 ~ "Neutral",
        4 ~ "Agree",
        5 ~ "Strongly Agree"
      ))

#3. replace_values() function

dat_1 <- tibble(
  city = c("Nrb","Nairobi","Tokyo", "New York", "NY", "Kampala")
)

# using case_when to replace values
dat_1 %>%
  mutate(
    city_1 = case_when(
      city %in% c("Nrb","Nairobi") ~ "Nairobi",
      city %in% c("New York", "NY") ~ "New York",
      .default = city
    )
  )

# using recode_values to replace values
dat_1%>%
  mutate(
    city_2 = recode_values(
      city,
      c("Nrb","Nairobi") ~ "Nairobi",
      c("New York", "NY") ~ "New York",
      default = city
    )
  )


#replace_when() function
