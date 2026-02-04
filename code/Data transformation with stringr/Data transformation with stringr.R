setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Data transformation with stringr")
#load libraries
library(stringr)

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

#character normalization


#2.Pattern detection and filtering
#detecting patterns



#filtering rows


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

