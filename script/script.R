url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("student-mat.csv", sep = ";")

#The description of all the variables can be read at url.data. It is also the
#url for the data

library(ggplot2)
library(dplyr)
library(ggthemes)
library(corrgram)
library(corrplot)

#Get a first look at the data
head(data)
names(data)
str(data)
sapply(data, class) #Find out the classes of the variables
any(is.na(data)) #No NA in the data

#Changing the classes of category variables from char to factor

#Finding correlations between numeric variables
num.col <- sapply(data, is.numeric)
cor.data <- cor(data[, num.col])
corr.plot <- corrplot(cor.data, method = "color")
