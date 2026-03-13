setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Web scraping")
#load libraries
library(rvest) #web scraping and HTML extraction
library(dplyr) #data manipulation and transformation
library(stringr) #string handling
library(janitor) #cleaning messy data

#read the wikipedia page
url <- "https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population"
page <- read_html(url)


