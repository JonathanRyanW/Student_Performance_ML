url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(corrgram)
library(corrplot)

#Changing the classes of category variables from char to factor

#Finding correlations between numeric variables
num.col <- sapply(data, is.numeric)
cor.data <- cor(data[, num.col])
corr.plot <- corrplot(cor.data, method = "color")
