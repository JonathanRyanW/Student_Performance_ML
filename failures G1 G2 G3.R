url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(corrplot)

"The failures variable indicates pass class failures. Of course students who
fails often are those who did not perform well on the class. We can expect that
the more failure a student has experienced the worse his/her grade will be. The
failure value is n if n <=3 and 4 if n >=4."

#Cleaning the data off 0 G3 values
data_clean <- filter(data, G3 != 0)

corrplot(cor(data_clean[, c("failures", "G1", "G2", "G3")]), method = "color")

#Creating scatter plots
ggplot(data, aes(x = failures, y = G1)) +
  geom_point() +
  theme_bw()

ggplot(data, aes(x = failures, y = G2)) +
  geom_point() +
  theme_bw()

ggplot(data, aes(x = failures, y = G3)) +
  geom_point() +
  theme_bw()

"I am starting to really hate this categorical variables. The visualizations are
simply ugly. But this plot actually still gives the truth. We can see that the
grades do decrease as failures decrease. But again, it is ugly."