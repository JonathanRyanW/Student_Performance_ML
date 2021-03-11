url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(corrplot)

"The question that i want to ask is, does having internet connection raises a
students grades or decrease it? Internet connection can increase a student's
grades by providing the students with supplementary lessons from the internet.
However it can also distract the student from studying and focusing on school."

"We can't find correlations here because the internet variable is a categorical
variable."

"Finding means of grades by internet connection availability"
Internet <- c(rep("No", 3), rep("Yes", 3))
Grade <- c("G1", "G2", "G3", "G1", "G2", "G3")
Mean <- c(mean(filter(data, internet == "no")$G1),
                 mean(filter(data, internet == "no")$G2),
                 mean(filter(data, internet == "no")$G3),
                 mean(filter(data, internet == "yes")$G1),
                 mean(filter(data, internet == "yes")$G2),
                 mean(filter(data, internet == "yes")$G3))
Mean <- round(Mean, 2)

grade.internet <- data.frame(cbind(Internet, Grade, Mean))
rm(Internet, Grade, Mean)

"The table shows us that students who has internet connection actually perform
better than those who don't have internet connection. There are many possible
explaination for this. One type of hypotheses would be that internet connection
helped the students in some way. The other type would be that having internet
connection is an indication for other things that possibly smarter kids have
more than less smart kids. Maybe having an internet connection means that the
kid's family is richer and richer families can afford private tutors or
additional courses. That's why these kids with internet connection perform
better."