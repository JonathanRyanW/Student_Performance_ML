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