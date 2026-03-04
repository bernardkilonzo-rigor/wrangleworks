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

#extracting fields
names <- page %>% html_nodes(".product-title")%>%html_text(trim = TRUE)

prices <- page %>% html_nodes(".product-price") %>% html_text(trim = TRUE)%>%
  str_replace_all("[^0-9]", "") %>% as.numeric()

reviews <- page %>% html_nodes(".reviews") %>% html_text(trim = TRUE)%>%
  str_remove_all("[()\\[\\]]") %>% as.numeric()

logistics <- page %>% html_nodes(".logistics-tag") %>% html_text(trim = TRUE)%>%
  str_remove_all('"')

mark <- page %>% html_nodes(".preferred-mark") %>% html_text(trim = TRUE)%>%
  str_remove_all('"')

#combine into a data set
phones <- tibble(
  name = names,
  price_ksh = prices,
  total_reviews = reviews,
  logistics_tags = logistics
)
