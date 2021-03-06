url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)
library(ggthemes)

#Finding correlations
correlation <- c(G1.G2 = cor(data$G1, data$G2),
                 G2.G3 = cor(data$G2, data$G3),
                 G1.G3 = cor(data$G1, data$G3))

"They all have very strong positive correlations. The interesting part is that
the correlation between g2 and g3 is stronger than between g1 and g3. It shows
us that more the more recent a grade is, the more reliable it is to predict the
next grade."

"It turns out there are some students who has 0 G2 and G3 values. The
question is did they actually took the test and get 0 or do they for some
reason did not take the tests? If they did take the test then it would be
very weird as some students did get 12, 10, or 9 in their first test. How
could they fall so far? I will assume that they did not take the test and 
thus the zeros indicates NAs, not actual 0 grade. This is further evidenced
by the fact that none of the students who has 0 G2 has non-zero value G3.
This suggests that the students are leaving the school. That is why they
have 0 test scores and why the students who has 0 G2 also has 0 G3."

sum(data$G2 == 0 & data$G3 != 0) #0 students have 0 in the G2 but not G3
sum(data$G2 == 0 & data$G3 == 0) #13 students have 0 in both G2 and G3
sum(data$G2 != 0 & data$G3 == 0) #25 students have 0 in G3 but not G2

#Looking at the data to be removed
removed <- filter(data, G3 == 0)

#Weeding out the zeros from the data
data_clean <- filter(data, G3 != 0)

#Finding the correlations again
correlation.clean <- c(G1.G2 = cor(data_clean$G1, data$G2),
                       G2.G3 = cor(data_clean$G2, data$G3),
                       G1.G3 = cor(data_clean$G1, data$G3))

"Our new correlations are even stronger than before! Of course this happens.
The zero values are undermining out positive correlations, with them gone we
get the true correlations. The new correlations still follows the same trend.
G2 predicts G3 better than G1 does."

#Plotting the data again
ggplot(data_clean, aes(x = G1)) +
  geom_bar() +
  theme_bw()

ggplot(data_clean, aes(x = G2)) +
  geom_bar() +
  theme_bw()

ggplot(data_clean, aes(x = G3)) +
  geom_bar() +
  theme_bw()

"Each of the data seems to be right-tailed."

"It might be interesting to find out why these people quit."

#
mean(removed$G1) #7.526316
mean(data_clean$G1) #11.26891

removed_g2 <- filter(removed, G2 != 0)
mean(removed_g2$G2) #7.08
mean(data_clean$G2) #11.35854

"Oh it becomes very clear that the people who left got worse grades than
those who continue on. Did they give up because they got bad grades in the
first test or in both the first and second test? If this is true these people
need to get their shit together. Having bad grades is ok, struggling in your
studies is ok, but giving up? Dude, seriously, you lose when you give up. If 
you keep trying things might change."

"It is interesting to know whether family problems are the cause of them
quitting."

table(data_clean$Pstatus) / 357 #Apart prob: 0.1092437
table(removed$Pstatus) / 38 #Apart prob: 0.05263158

"Oh it is not true at all. People who quit actually have less chance of
being in a family where the parents live apart. So most of them can't use
family problems to justify them giving up. Oh this is interesting! Could it
be that it is actually the fact that their parents are still together that
causes them to give up? Could it be that because both parents are in the
house the student felt more pressure to perform. We know that they have
considerably worse grade. Could it be that telling both your parents about
your bad grade is harder than telling just one of them? It could also be
that these kids live in a happy family and because they are happy the students
do not want to disturb that happiness by reporting their bad grades. Thus
giving more pressure for them to perform. They ended up giving up altogether."

"Ok we will not explore the reasons behind them quitting any further. We can
be satisfied with the findings about their bad grades. There are many other
things we can focus on."

#Creating scatter plots
ggplot(data_clean, aes(x = G1, y = G2)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("G1 and G2") +
  theme_bw()

ggplot(data_clean, aes(x = G1, y = G3)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("G1 and G3") +
  theme_bw()

ggplot(data_clean, aes(x = G2, y = G3)) +
  geom_point(size = 2) +
  geom_smooth(method = "lm", se = FALSE) +
  ggtitle("G2 and G3") +
  theme_bw()

"The plots are very neat because the values are expressed as an integer. I
doubt that this is actually the case in the real life. I don't think schools
gave their students grades in integer from 1 to 10. They usually have some
decimal values."