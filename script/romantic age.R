url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

"The data only consist of 4,1,1 students with the age of 20,21,22. This number
of samples are too low to make any results reliable. We are omiting the data of
these students. We will analyze the data from age 15 to 19"

ggplot(filter(data, age != 20 & age != 21 & age != 22), aes(x = romantic)) +
  geom_bar(aes(fill = as.factor(age)), position = "dodge") +
  xlab("Romantic Relationship?") +
  ylab("Number of Students") +
  #coord_cartesian(ylim = c(0,300)) +
  ggtitle("Age & Romantic Relationship") +
  theme_bw()

"This plot shows the number of students based on age and romanic relationship,
but not the probability."

prob.romantic.age <- tapply(data$romantic, data$age,
                            function(x){
                              return(table(x) / length(x))
                            }
)
df <- matrix(c(15,16,17,18,19,20,21,22), nrow = 8)
temp <- rbind(prob.romantic.age[[1]], prob.romantic.age[[2]], prob.romantic.age[[3]],
              prob.romantic.age[[4]], prob.romantic.age[[5]], prob.romantic.age[[6]],
              prob.romantic.age[[7]], prob.romantic.age[[8]])
df <- data.frame(cbind(df, temp))
rm(temp, prob.romantic.age)
df[7,3] <- 0
df[8,2] <- 0
romantic_age <- rename(df, Age = V1)
rm(df)

"From this table we can see that the probability of being in a romantic
relationship does increase as age increases all the way to the age of 19.
The 20,21, and 22 age should not be included due to the sample size being too
small. Now all we have to do is to visualize the data."

#Tidying the data
romantic_age <- gather(romantic_age,
                       key = "Romantic Relationship",
                       value = "Probability",
                       no, yes)

#Visualizing the probabilities
ggplot(romantic_age[1:5,], aes(Age, yes)) +
  geom_jitter() +
  coord_cartesian(xlim=c(15,19)) +
  theme_bw()

"How to do this better?"