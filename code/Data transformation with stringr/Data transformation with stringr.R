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
#validating passwords
z<- tibble(
  password =c(
    "Zorigor2025",
    "bernard3012",
    "Rigordata2020",
    "Bensolutions2012",
    "Ben2021",
    "Kenrastli2020"
  )
)

validate_password <- function(z) {
  has_upper <- str_detect(z, "[A-Z]")
  has_lower <- str_detect(z, "[a-z]")
  has_digit <- str_detect(z, "\\d")
  long_enough <- str_length(z) >= 8
  
  has_upper & has_lower & has_digit & long_enough
}
z%>%mutate(valid_pasword = validate_password(password))

#email validation
is_valid_email <-function(x){
  str_detect(x, "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")
}
is_valid_email("benkilonzo@gmail.com")
is_valid_email("rigordatasolutions.com")

#phone validation
is_valid_ke_contact <- function(x){
  str_detect(x, "^(\\+254|0)7[0-9]{8}$")
}
is_valid_ke_contact("+254713567549")
is_valid_email("+2745362178")

#validating if product name contains certain pattern
superstore<-superstore%>%mutate(Xerox_products = str_detect(Product.Name,"Xerox"))

#3.Extracting and splitting text
#extracting
str_extract("Bernard Kilonzo", "^[^ ]+") #extracts  first name
str_extract("Bernard Kilonzo", "[^ ]+$") #extracts last name
str_sub("Rigordatasolutions",1,5) #extracting text by position
str_sub("Rigor1234",-4,-1) #extracting text by position

#splitting

str_split(superstore$Customer.Name,"\\s+") #splits text on white space
str_split("Rigor,Data,Solutions", ",") #splits text on comma
str_split_fixed(superstore$Order.ID,"-",3) #splits text into a fixed number of parts

#4.Replacing and rewriting text
#simple replacement
text <- "Rigor Data Solutions Offers Data Analysis Solutions"
str_replace(text, "Solutions", "Services") #replaces first occurrence
str_replace_all(text, "Solutions", "Services") #replaces all occurrences
str_remove(text, "Solutions") #similar to replacing first occurrence of "Solutions" with ""
str_replace_all(text, c("Solutions" ="Services", "Analysis"="Visualization")) #multiple replacement at once

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

