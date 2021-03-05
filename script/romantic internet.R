url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(ggplot2)
library(dplyr)

table(data$internet)

"First of all, most students (329 out of 395 = 83.2%) does have an internet
connection"

"Creating a bar plot of romantic relationships by internet connection"

ggplot(data, aes(romantic)) +
  geom_bar(aes(fill = internet)) +
  coord_cartesian(ylim = c(0,300)) +
  theme_bw()

"It is not immediately clear. Finding the actual probabilities and storing
them into a data frame called romantic_internet."

temp <- filter(data, internet == "no")
prob.no.internet <- table(temp$romantic) / length(temp$romantic)

temp <- filter(data, internet == "yes")
prob.internet <- table(temp$romantic) / length(temp$romantic)

romantic_internet <- data.frame(Internet = c("No", "Yes", "No", "Yes"),
                                Romantic = c("No", "No", "Yes", "Yes"))

Probability <- c(prob.no.internet[1], prob.internet[1], prob.no.internet[2], prob.internet[2])
romantic_internet <- cbind(romantic_internet, Probability)
rm(temp, prob.internet, prob.no.internet, Probability)

"We get our data frame romantic_internet. It is already tidy. There is no need
to use the tidyr package. From this data frame we can clearly see evidence
that having an internet connection does increases the chances of being in a
romantic relationship. But this is not yet proven. It could be that having an
internet connection means you are richer than the other folks who dont have
internet connecetion and because you are richer than them then you have higher
chance of being in a relationship. We can find this connection by examining
their family's income. "