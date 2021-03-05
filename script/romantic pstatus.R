url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(ggplot2)
library(dplyr)
library(tidyr)

#Finding the prob of romantic relationship by parental status
prob.romantic.Pstatus <- tapply(data$romantic, data$Pstatus,
                                function(x){
                                  return(table(x) / length(x))
                                })
df <- matrix(c("A", "T"), nrow = 2)
temp <- rbind(prob.romantic.Pstatus[[1]], prob.romantic.Pstatus[[2]])
df <- data.frame(cbind(df, temp))
rm(temp, prob.romantic.Pstatus)
romantic_Pstatus <- rename(df, Pstatus = V1)
rm(df)

#Tidying the data
romantic_Pstatus <- gather(romantic_Pstatus,
                           key = "Romantic Relationship",
                           value = "Probability",
                           no, yes)

"Ok now this is counter intuitive. It turns out that students whose parents
are living apart is actually more likely to be in a relationship than other
students whose parents are still together. It could be that because their
parents are living apart, they probably do not provide enought love for 
their children. As a consequence the children need to find love from other
source, that is, their bf/gf. Right now it really is just a conjecture. We
need to read some journals in psychology to know the truth. But this is
interesting"

ggplot(data, aes(x = romantic)) +
  geom_bar(aes(fill = Pstatus)) +
  xlab("Romantic Relationship?") +
  ylab("Number of Students") +
  coord_cartesian(ylim = c(0,300)) +
  ggtitle("Parent Marriage Status & Romantic Relationship") +
  theme_bw()