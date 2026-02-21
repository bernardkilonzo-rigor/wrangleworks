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


#recode_values() function



#replace_values() function



#replace_when() function
