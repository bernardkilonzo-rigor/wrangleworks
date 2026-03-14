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

#extract the right table (in this case the first table)
df <- tables[[1]]
lapply(df,head) #inspecting the table


