url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)

"we want to know whether students from one of the schools have higher chances
of being in a romantic relationship."

School <- c("GP", "GP", "GP", "GP", "MS", "MS", "MS", "MS")
Sex <- c("F", "F", "M", "M", "F", "F", "M", "M")
Romantic <- c("yes", "no", "yes", "no", "yes", "no", "yes", "no")
romantic.school <- cbind(School, Sex, Romantic)

Probability <- c()
for (i in 1:8) {
  temp <- filter(data,
                 school == romantic.school[i,1],
                 sex == romantic.school[i,2])
  Probability <- append(Probability, sum(temp$romantic == romantic.school[i,3]) / length(temp$romantic))
}
Probability <- round(Probability, 2)
romantic.school <- data.frame(cbind(romantic.school, Probability))
rm(i, temp, Romantic, School, Sex, Probability)

"There is no difference in the probability of being in a relationship for males.
However there is a 16% difference for females. Females from the MS school are
16% more likely to be in a romantic relationship compared to females from the
GP school.

We have established that being in a relationship decreases the students grade.
We have also established that students from the MS school perform worse than GP.
Our newest finding is aligned with the previous ones. The data is consistent."