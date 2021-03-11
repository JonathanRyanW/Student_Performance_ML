url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)

table(data$school)
table(data$school) / length(data$school)

"88.35% of the data is from the GP school. Oh my God there is only 46 students
from MS school. The sample number is soo low."

School <- c("GP", "GP", "GP", "MS", "MS", "MS")
Grade <- c("G1", "G2", "G3", "G1", "G2", "G3")
Mean <- c(mean(filter(data, school == "GP")$G1),
          mean(filter(data, school == "GP")$G2),
          mean(filter(data, school == "GP")$G3),
          mean(filter(data, school == "MS")$G1),
          mean(filter(data, school == "MS")$G2),
          mean(filter(data, school == "MS")$G3))
Mean <- round(Mean, 2)
grade.school <- data.frame(cbind(School, Grade, Mean))
rm(School, Grade, Mean)

"Nevertheless, students from the GP school consistently performs better on
average than the students in MS school."

ggplot(data, aes(x = G1)) +
  geom_bar(aes(fill = school)) +
  theme_bw()