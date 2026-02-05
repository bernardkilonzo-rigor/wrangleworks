setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Data transformation with stringr")
#load libraries
library(stringr)
library(dplyr)

#loading sample dataset
superstore <-read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")

#1.Cleaning and standardizing text
#white space and formatting
#trim spaces
x<- "Rigor Data  Solutions "
str_trim(x) #trims both sides
str_trim(x, side = "left") #trim leading spaces
str_trim(x, side = "right") #trim trailing spaces
str_replace_all(x, "\\s+","") #removes all white spaces
str_squish(x) #collapses multiple spaces into one

#case transformations

str_to_lower(x) #lowercase
str_to_upper(x) #uppercase
str_to_title(x) #title case
str_to_sentence(x) #sentence case

#2.Pattern detection and filtering
#detecting patterns
y <-c("abc@fun.org", "abc.com", "abc@gmail.com")

str_detect(x, "Data") #detect simple sub strings
str_detect(x, regex("DATA", ignore_case = TRUE)) #detect case‑insensitively
str_detect(y, "@.+\\.") #Checks for “@something.” a crude email pattern
str_detect(x, "\\d+") #detect digits
str_detect(x, "\\w+") #detect word characters
str_detect(x, "\\s+") #detect white spaces
str_count(x,"o") #great for counting occurrences.

#filtering rows

superstore%>%filter(str_detect(Product.Name,"Xerox")) #filters "Xerox" products
superstore%>%filter(str_starts(Customer.Name,"El"))  #filters names starting with "El"
superstore%>%filter(str_ends(Customer.Name,"cio")) #filters names ending with "cio"
superstore%>%filter(!str_detect(Category,"Technology")) #excludes technology category


#validating inputs


#3.Extracting and splitting text
#extracting



#splitting



#tokenization (lightweight NLP)


#4.Replacing and rewriting text
#simple replacement


#Regex-driven rewriting



#dynamic replacement


#5.String construction and assembly
#concatenation


#interpolation


#joining vectors


#6.Measuring and summarizing text
#length and width


#summaries


#7.Advanced Regex and Text Engineering
#lookaheads and lookbehinds


#boundary matching


#complex parsing

