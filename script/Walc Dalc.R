url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)

mean(data$Walc) #2.291139
mean(data$Dalc) #1.481013

"So students are drinking more alcohol on the weekends rather than the weekdays.
This makes perfect sense. Students don't go to school at weekends. They have
more opportunity to think about alcohol during weekends. Also students usually
spent time hanging out with friends on the weekends, they are more likely to
consume alcohol at this time."

corrplot(cor(data[, c("Walc", "Dalc", "studytime")]), method = "color")

"Walc and Dalc have strong positive correlation. Of course this is true.
Consuming more alcohol on the weekdays indicates that someone also consuming
more alcohol in the weekends. People don't usually drink only on weekends or
only on weekdays. If someone is an alchoholic, they drink everyday."

"The interesting connection is between alcohol consumption and studytime. It
turns out that the more alcohol a student consume, the less time they spent
studying. Maybe this is logical since people don't usually drink alcohol when
they are studying. At least i don't know anyone who does that. Btw, can people
even focus on their studies if they are drunk or even slightly drunk? I think
it's impossible, being drunk shuts down your brain. This explains the negative
correlation. Students can't study while drinking, which means the more a
student drink, the less time he/she can spent studying.

However there is an alternative explanation. This data is taken from a survey.
It could be that students who want to look cool tend to give high number for
their alcohol consumption because it gives an aura of adultness and coolness
and low time studying because studying is associated with nerdiness and lameness.
This is why the 2 variables are negatively correlated."

Walc.Dalc.model <- lm(Walc ~ Dalc, data)
summary(Walc.Dalc.model)

"The model is Walc = 0.90452 + 0.93626 * Dalc. The Adjusted R-squared:  0.4178.
Not too bad but certainly incredibly good."

cor(data$Walc, data$studytime)

#Creating scatter plots. At this point, i already know that the result will be
#ugly.

ggplot(data, aes(x = Walc, y = studytime)) +
  geom_point() +
  theme_bw()

"Very bad and useless graph"