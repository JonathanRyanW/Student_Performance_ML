#findout how many females and males there are
sum(data$sex == "F")
sum(data$sex == "M")

"208(52.6%) females and 187(47.3%) males"

#find out proportion of those with romantic relationship
sum(data$romantic == "yes")
sum(data$romantic == "no")

"132(33.4%) people is in a romantic relationship out of 395"

temp <- filter(data, sex == "F")
sum(temp$romantic == "yes")

temp <- filter(data, sex == "M")
sum(temp$romantic == "yes")

rm(temp)
"79 out of 208 (37,98%) of females are in romantic relationship"
"53 out of 187 (28.34%) of males are in romantic relationship"

"This is weird. There are more females than males, if anyone should be in a
romantic relationship it should be males because they have more options to
choose from. The probability for males should be higher, but that is not the
case. Could it be that the females are in a relationship with males from other
schools? Is that a general trend?"

#Creating barplots to visualize the count based on romantic relationship
#based on gender

ggplot(data, aes(x = romantic)) +
  geom_bar(aes(fill = sex)) +
  xlab("Romantic Relationship?") +
  ylab("Number of Students") +
  coord_cartesian(ylim = c(0,300)) +
  ggtitle("Students & Romantic Relationship") +
  theme_bw()

"The resulting plot shows something funny. The number of males not in a
romantic relationship is roughly equal the their female counterpart. They
should all just go out. For those in a romantic relationship, females hold
the majority. The plot is saved in the output folder in a png file named
Gender & Romantic Relationship.png"

"It is also interesting to find out whether age, parental status, internet,
and other variables effect romantic relationship. It could be that students
with internet connection are more likely to be in a relationship because they
can chat with their friends and thus increasing the likelihood of falling in
love with one of them. It could be that students with parents who lived apart
are traumatized by the event and thus less likely to be in a romantic
relationship themselves. It is very logical that as the students age increases
their likelihood to be in a romantic relationship also increases"

#age and students

"The data only consist of 4,1,1 students with the age of 20,21,22. This count
is to low to make any generalization. We are omiting the data of these students
"
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

"From this table we can already see that the probability of being in a romantic
relationship does increases as age increases all the way to the age of 19.
The 20,21, and 22 age should not be included fue to the sample size being too
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
  # coord_cartesian(ylim = c(0,300)) +
  ggtitle("Parent Marriage Status & Romantic Relationship") +
  theme_bw()
