url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

"freetime and goout should be positively correlated. Because as a student's
free time increases, they should have more time to goout. But it could be wrong.
It could be that a low goout indicates high free time. Because they seldom go
out with their friends, they have more free time."

#Finding correlation
correlation <- cor(data$goout, data$freetime)

'It turns out that our initial hypotheses is true. freetime and goout is
positvely correlatted.'