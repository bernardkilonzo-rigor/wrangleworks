setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Web scraping")
#load libraries
library(rvest) #HTML scraping
library(dplyr) #data wrangling
library(stringr) #text cleaning
library(janitor) #clean column names

#read the Wikipedia page
url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
page <- read_html(url)

#extract all tables
tables <- page %>%html_table(fill = TRUE)
length(tables) #tells how many tables are detected
lapply(tables,head) #inspecting the tables

#extract the right table (in this case the first table)
df <- tables[[1]]%>%select(-Notes)#drops column on Notes
lapply(df,head) #inspecting the data

#convert Population from character to numeric
df$Population <-as.numeric(gsub(",","",df$Population))

#convert %ofworld from character to percent
df$`% ofworld` <- as.numeric(gsub("%","",df$`% ofworld`))/100

#convert date from character to a date
df$Date <- as.Date(df$Date, format = "%d %b %Y")

#export  sample data as a CSV


