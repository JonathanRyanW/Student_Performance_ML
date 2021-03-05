url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)

"We previously did some analysis with the romantic and Pstatus variables.
Based on the results, we made a hypotheses that the reason why students whose
parents are apart are more likely to be in a relationship is because they need
to get the love they were devoid of from their parents."

"It turns out there is an additional variable called famrel that represents
the quality of family relationship. We will assume that this variable is valid
We will do some analysis on the connection between romantic and famrel."

"The famrel variable is a categorical variable with values of 1, 2, 3, 4, 5.
The higher the value, the better the family relationship. If our hypotheses
that romantic relationship stems from the need of love that went missing
because of the separation between the parents then students with higher famrel
should have lower probability to be in a romantic relationship."

#Creating the data frame
romantic_famrel <- data.frame(famrel = c(1,1,2,2,3,3,4,4,5,5),
                              romantic = c("no", "yes", "no", "yes", "no", "yes", "no", "yes", "no", "yes"))
Probability <- c()
for (i in 1:5){
  temp <- filter(data, famrel == i)
  Probability <- c(Probability, table(temp$romantic) / length(temp$romantic))
}
romantic_famrel <- cbind(romantic_famrel, Probability)
rm(i, temp, Probability)

"Ok now we have conflicting results. From the table we can see that as famrel
increases between the values of 1,2,3 the probability of being in a relationship
actually increases. I don't know what is going on. The probability should be
decreasing. Right now the only thing i can do is to read some journals in this
topic and find out the actual truth."