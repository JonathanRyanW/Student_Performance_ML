url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(corrgram)
library(corrplot)

#Changing the classes of category variables from char to factor

#Finding correlations between numeric variables
num.col <- sapply(data, is.numeric)
cor.data <- cor(data[, num.col])
corr.plot <- corrplot(cor.data, method = "color")
rm(num.col, cor.data)

"If we use the corrgram package we dont need to filter only the numeric
variables"

corrgram(data)

"Ada banyak informasi yang bisa dikasih oleh corrgram. Untuk bisa pake package
ini semaksimal mungkin kita harus mengerti argumen2nya."

?corrgram
