url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)
library(corrplot)

correlation <- corrplot(cor(data[, c("goout", 'freetime', "studytime",
                                     "G1", "G2", "G3")]),
                        method = "color")

"From this correlation plot. We can see that free time has almost zero
correlation with all the grades. Studytime also has very weak correlation. How
could this be true? The more time a student spent studying the better his/her
grades should be. But this is not the case at all."

ggplot(data, aes(x = goout, y = G1)) +
  geom_point() +
  geom_smooth(method = "lm", se = F) +
  theme_bw()

"Building a plot using goout, freetime, and studytime is also useless. The data
is categorical, we can't make any meaningful insights with this plot. Again,
they should have used continuous variables since goout, freetime, and studytime
is in fact continuous. This survey is not well made."