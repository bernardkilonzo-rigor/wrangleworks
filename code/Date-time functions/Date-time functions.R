setwd("C:\\Users\\berna\\OneDrive\\Desktop\\Production\\wrangleworks\\code\\Date-time functions")
#load libraries
library(tidyverse)

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


#4.Adding/subtracting time units

#adding 1 year to the Order Date
superstore<-superstore%>%
  mutate(date_year = Order.Date+years(1))
  
#adding 1 month to the Order Date
superstore<-superstore%>%
  mutate(date_month = Order.Date+months(1))

#subtracting 3 months from the Order Date
superstore<-superstore%>%
  mutate(data_month_3 =Order.Date-months(3))


#5.Computing the difference between dates

#computing the difference between Order Date and Ship Date
superstore<-superstore%>%
  mutate(difference = Ship.Date-Order.Date)

#computing the difference by specifying the time length
superstore<-superstore%>%
  mutate(diffe_2 = time_length(interval(Order.Date,Ship.Date),"month"))


#6.Rounding dates to the nearest units

#rounding Order Date to the nearest month
superstore<-superstore%>%
  mutate(round_month =round_date(Order.Date,"month"))

#rounding Order Date to the nearest year
superstore<-superstore%>%
  mutate(round_year =round_date(Order.Date,"year"))


#7.Extracting weekdays and months

#extracting weekdays and months as integers
#extracting weekdays from Order Date
superstore<-superstore%>%
  mutate(weekday = wday(Order.Date))

#extracting months from Order Date
superstore<-superstore%>%
  mutate(month = month(Order.Date))

#extracting weekdays and months as fcators
#extracting weekdays from Order Date
superstore<-superstore%>%
  mutate(wkday = wday(Order.Date, label = TRUE))

#extracting months from Order Date
superstore<-superstore%>%
  mutate(mon = month(Order.Date, label = TRUE))


#8.Creating a date sequence
#the function below creates a sequence between the two dates
seq(dmy(01012021),dmy(31122024),by ="days")


#9.Working with time zones
#Converting my timezone to EST and UTC zones respectively
with_tz(now(), tzone = "EST")
with_tz(now(), tzone = "UTC")


#10.Formatting date outputs
#different ways of formatting the current date
format(now(),"%a") #"Tue"
format(now(),"%A") #"Tuesday"
format(now(),"%b") #"Sept"
format(now(),"%B") #"September"
format(now(),"%b-%Y") #"Sept-2025"
format(now(),"%b-%y") #"Sept-25"
format(now(),"%b %d,%Y") #"Sept 02,2025"