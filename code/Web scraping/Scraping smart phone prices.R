#load libraries
library(dplyr) #data manipulation and transformation
library(stringr) #string handling
library(purrr) #functional programming and iteration
library(rvest) #web scraping and HTML extraction

#case 1: scrapping smartphones data from Kilimall eCommerce site
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

#scrapping multiple pages from kilimall site
scrape_page <- function(page_num){
  url <-paste0("https://www.kilimall.co.ke/category/Top-Brands?id=100000646&form=category&page=",page_num)
  
  page <- read_html(url)
  
  names <- page %>% html_nodes(".product-title")%>%html_text(trim = TRUE)
    
  prices <- page %>% html_nodes(".product-price") %>% html_text(trim = TRUE)%>%
      str_replace_all("[^0-9]", "") %>% as.numeric()
    
  reviews <- page %>% html_nodes(".reviews") %>% html_text(trim = TRUE)%>%
      str_remove_all("[()\\[\\]]") %>% as.numeric()
  
  logistics <- page %>% html_nodes(".logistics-tag") %>% html_text(trim = TRUE)%>%
      str_remove_all('"')
  
  mark <- page %>% html_nodes(".preferred-mark") %>% html_text(trim = TRUE)%>%
      str_remove_all('"')
  
  tibble(
    name = names,
    price_ksh = prices,
    total_reviews = reviews,
    logistics_tags = logistics,
    page = page_num
  )
}

#looping through multiple pages
scraping_10pages <-map_df(1:10, scrape_page)

#case 2: scrapping smartphones data from Jumia eCommerce site
#target page
url_2 <- "https://www.jumia.co.ke/catalog/?q=smartphones"

#read the html
page_2 <- read_html(url_2)

#extracting the fields
names <- page_2 %>% html_nodes(".name")%>%html_text(trim = TRUE)

current_price <- page_2 %>% html_nodes(".prc") %>% html_text(trim = TRUE)%>%
  str_replace_all("[^0-9]", "") %>% as.numeric()

old_price <- page_2 %>% html_nodes(".old") %>% html_text(trim = TRUE)%>%
  str_replace_all("[^0-9]", "") %>% as.numeric()

price_deviation <- page_2 %>% html_nodes("._dsct") %>% html_text(trim = TRUE)%>%
  str_replace_all("[^0-9]", "") %>% as.numeric()/100

total_reviews <- page_2 %>% html_nodes(".rev") %>% html_text(trim = TRUE)%>%str_extract("(?<=\\()\\d+(?=\\))")

rating<- page_2 %>% html_nodes(".rev") %>% html_text(trim = TRUE)%>%str_extract("\\d+\\.?\\d*")

#combining extracted fields to create a data set
phones_2<-tibble(
  name = names,
  current_price_ksh = current_price,
  old_price_ksh = old_price,
  price_dv =price_deviation,
  rating = rating,
  total_reviews = total_reviews
)

#scrapping multiple pages from Jumia eCommerce site
scrape_page_1 <- function(page_num){
  url <-paste0("https://www.jumia.co.ke/catalog/?q=smartphones&page=",page_num)
  
  page_2 <- read_html(url)
  
  names <- page_2 %>% html_nodes(".name")%>%html_text(trim = TRUE)
  
  current_price <- page_2 %>% html_nodes(".prc") %>% html_text(trim = TRUE)%>%
    str_replace_all("[^0-9]", "") %>% as.numeric()
  
  old_price <- page_2 %>% html_nodes(".old") %>% html_text(trim = TRUE)%>%
    str_replace_all("[^0-9]", "") %>% as.numeric()
  
  price_deviation <- page_2 %>% html_nodes("._dsct") %>% html_text(trim = TRUE)%>%
    str_replace_all("[^0-9]", "") %>% as.numeric()/100
  
  total_reviews <- page_2 %>% html_nodes(".rev") %>% html_text(trim = TRUE)%>%str_extract("(?<=\\()\\d+(?=\\))")
  
  rating<- page_2 %>% html_nodes(".rev") %>% html_text(trim = TRUE)%>%str_extract("\\d+\\.?\\d*")
  
  tibble(
    name = names,
    current_price_ksh = current_price,
    old_price_ksh = old_price,
    price_dv =price_deviation,
    rating = rating,
    total_reviews = total_reviews,
    page = page_num
  )
}

#looping through multiple pages
scraping_5pages <-map_df(1:5, scrape_page_1)
