setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Date-time functions")
#load libraries
library(lubridate)

#load data
superstore<-read.csv("https://raw.githubusercontent.com/bernardkilonzo-rigor/dataviz/main/data/Sample%20-%20Superstore.csv")
View(superstore)
#Date and time functions in R

#1.Converting dates from other formats

#converting Order Date to a date object
superstore$Order.Date<-dmy(superstore$Order.Date)

#converting Ship Date to a date object
superstore$Ship.Date<-as.Date(superstore$Ship.Date, format = "%d/%m/%Y")

#2.Computing the current date and time

#using lubridate now() function
now()

#using Sys_date or Sys_time() functions
Sys.Date()
Sys.time()

#3 Extracting date components

#extracting the year, month, and day components from the Order Date
year(superstore$Order.Date) #extracting years
month(superstore$Order.Date) #extracting months
day(superstore$Order.Date) #extracting days



