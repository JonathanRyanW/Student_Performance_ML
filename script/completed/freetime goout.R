url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(ggplot2)

"freetime and goout should be positively correlated. Because as a student's
free time increases, they should have more time to goout. But it could be wrong.
It could be that a low goout indicates high free time. Because they seldom go
out with their friends, they have more free time."

#Finding correlation
cor(data$goout, data$freetime) #0.2850187

'It turns out that our initial hypotheses is true. freetime and goout is
positvely correlatted. However the correlation is weak.'

#Creating a scatter plot
ggplot(data, aes(x = freetime, y = goout)) +
  geom_point() +
  theme_bw()

"This plot does not give any meaningful information because both the variables
are categorical. This fact probably undermine the correlation too. It would be
better to have continuous freetime and goout values since time is continuous."
