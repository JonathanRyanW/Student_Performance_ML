url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)

"When we were doing some EDA on the grades, we found out that some students have
0 G2 or G3 variables. We then make the deduction that these students didn't take
the tests and get 0 but rather left the school. This script will analyze them.
We want to find the characteristics defining students who quits the school."

#data of the quitters
quit <- filter(data, G3 == 0)

#data of students who continue on
data_clean <- filter(data, G3 != 0)

#Finding out exactly how many students quit in each period
sum(data$G2 == 0 & data$G3 != 0) #0 students have 0 in the G2 but not G3
sum(data$G2 == 0 & data$G3 == 0) #13 students have 0 in both G2 and G3
sum(data$G2 != 0 & data$G3 == 0) #25 students have 0 in G3 but not G2

"It turns out that 13 students quit before the second period's test. And then
25 students quit before the third period's quiz. A total of 38 quitters."

mean(data_clean$age) #16.65546
mean(quit$age) #17.07895

"The mean age of the quitters is higher than those who continue on. However
the difference is very small, only 0.42349, that is 0.42349 * 12 = 5 months.
The quitters are on average 5 months older than those who continue on.

Is this even enough to make any interpretation?"

table(data$sex) / length(data$sex)
table(quit$sex) / length(quit$sex)

"It turns out that the proportion of sex in the quitters data is a little bit
different than in the general population. We did not use the clean data because
we want to compare these proportion with the general population.

Our table shows that females are more likely to quit rather than males. Why is
this true? Are females just less determined than males? This is weird, but
could it be that some of the females are quitting because they are being
married to some guy and thus become a housewife in their teenage years?

If this is true and they are answering the survey truthfully. Then we should
see that most of the girls who quit are in a romantic relationship."

table(filter(quit, sex == "F")$romantic) / length(filter(quit, sex == "F")$romantic)
table(filter(data, sex == "F")$romantic) / length(filter(data, sex == "F")$romantic)
table(filter(data_clean, sex == "F")$romantic) / length(filter(data_clean, sex == "F")$romantic)

"Oh now we see it. That is very true the girls who quit have higher probability
of being in a romantic relationship. The quitter girls have 65% chance while
the general population have 38% chance. The students who continue on have
34.5% chance. The difference is staggerin!

What about the males?"

table(filter(quit, sex == "M")$romantic) / length(filter(quit, sex == "M")$romantic)
table(filter(data, sex == "M")$romantic) / length(filter(data, sex == "M")$romantic)
table(filter(data_clean, sex == "M")$romantic) / length(filter(data_clean, sex == "M")$romantic)

"The same thing is true for males but not that much difference can be seen."

#Finding grades discrepancies between quitters and other students.
mean(removed$G1) #7.526316
mean(data_clean$G1) #11.26891

removed_g2 <- filter(removed, G2 != 0)
mean(removed_g2$G2) #7.08
mean(data_clean$G2) #11.35854

"The students who left got worse grades than those who continue on. Did they
give up because they got bad grades in the first test or in both the first and
second test? If this is true these people need to get their shit together.
Having bad grades is ok, struggling in your studies is ok, but giving up? Dude,
seriously, you lose when you give up. If you keep fighting things might change."

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

"We will build a logistic regression model to predict which student will
quit and which ones will continue. We will build 3 models. The first model
will predict whether a student will quit before the second period's test. That
is the students with 0 G2 and G3 grades. The input will be all the variables
all they way to G1. The second model will predict which students will quit
before the third period's test but after they have done the second period's
test. That is the students with 0 G3 grade and non-zero G2 grade. The input will
be all of the variables all the way to G2. The third model will predict whether
a student quits at all this model is basically the union of the first 2 model.
we have a few choices for the inputs. Either we use all the variables all the way
to G1 or G2 or G3 with quitters grade represented by 0."

"Before we begin, we should add a new column indicating whether someone quit
before G2 test or G3 test. quit2 indicates whether a student quits before G2.
quit3 indicates whether a student quit before G3 but after G2. quit indicates
whether the student quits at all.

And also we need to change all of the categorical variables into factor values.
"


quit2 <- 
