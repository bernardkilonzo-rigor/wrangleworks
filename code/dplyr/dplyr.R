setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\dplyr")

#load dplyr library
library(dplyr)

#load data set
superstore <- read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")

#filter_out() function
df <- tibble(
  name = c("Ann","Ken","Jack", "Anita", "Alex", "Walter", "Ruth", "Lucy"),
  Status = c("Present", "Absent", "Absent", "Present","Absent","Present","Present", "Absent"),
  Amount = c(1000,867,1200,890,3400,1234,600,340)
)
#using filter() to drop records where status "present" and Amount>=1000
df%>%filter(!(Status=="Present" & Amount>=1000))

#using filter_out() to drop records where status "present" and Amount>=1000
df%>%filter_out(Status=="Present", Amount>=1000)

#recode_values() function
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

#replace_values() function



#replace_when() function
