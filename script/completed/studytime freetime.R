url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(ggplot2)

"studytime and freetime should be negatively correlated. When a student spent 
time studying, they can't use that time to do anything else. Meaning that their
free time decreases."

cor(data$studytime, data$freetime) #-0.1431984

"Our initial hypotheses was correct. The 2 variables are indeed negatively
correlated. However the correlation is a weak one."

"Creating a plot of studytime and freetime does not make any sense as they are
categorical variables. They are on the ordinal scale. If we did make a scatter
plot, we would get a completely meaningless plot. It is better to have
continuous freetime and studytime variable since they are continuous."

#This plot is utterly useless
ggplot(data, aes(x = studytime, y = freetime)) +
  geom_point() +
  theme_bw()