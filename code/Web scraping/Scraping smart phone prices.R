setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Web scraping")

#load libraries
library(dplyr) #data manipulation and transformation
library(stringr) #string handling
library(purrr) #functional programming and iteration
library(rvest) #web scraping and HTML extraction

#target page
url <- "https://www.kilimall.co.ke/category/Top-Brands?id=100000646&form=category&page=1"

#read the HTML
page <- read_html(url)
