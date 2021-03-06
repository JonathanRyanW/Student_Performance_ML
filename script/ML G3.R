url.data <- "https://archive.ics.uci.edu/ml/datasets/Student+Performance"
data <- read.csv("./data/student-mat.csv", sep = ";")

library(dplyr)
library(ggplot2)
library(ggthemes)
library(caTools)

"We will predict G3 using a linear regression model with G1 and G2 as inputs."

#Cleaning the data off 0 G3 values
data_clean <- filter(data, G3 != 0)

#Splitting data into training and testing data
set.seed(101)
sample <- sample.split(data_clean$G3, SplitRatio = 0.7)

train_data <- filter(data_clean, sample)
test_data <- filter(data_clean, !sample)

model.G1.G2 <- lm(G3 ~ G1 + G2, train_data)

#Interpreting the model
summary(model.G1.G2)

"It looks like the model uses G2 more than it uses G1. It makes sense because
G2 is more strongly correlated to G3 than G1 does. This must also be a case of
auto-correlation."

#Plotting out the residuals
res <- residuals(model.G1.G2)
res <- as.data.frame(res)
ggplot(res, aes(x = res)) +
  geom_histogram(binwidth = 0.1)

#Predicting G3 of the test data
predictions <- predict(model.G1.G2, test_data)
result <- cbind(test_data$G3, predictions)
result <- as.data.frame(result)
mse <- mean((result$V1 - result$predictions)^2)

"Next we will try to predict G3 using a linear regression model with every
variable that we have as the input"

model.everything <- lm(G3 ~ . , train_data)
summary(model.everything)

#Plotting the residuals
res <- residuals(model.everything)
res <- as.data.frame(res)
ggplot(res, aes(x = res)) +
  geom_histogram()

"The residuals look like they are normally distributed. A very good sign."

"We find that in this model G1 is not even significant. The significant
variables in descending order of their significance are G2, famrel, health,
and Mjobother. G2 is not surprising, but famrel is! Oh my God! famrel affects
G3 significantly? This is a profound discover! So family relationship matters
huh. Wait a minute, why does health has a negative coefficient? And why does
only Mjobother effects G3 and not other jobs? It suggests that if a student
gives out other in their mother's job"

"Adjusted R-squared of this model is 0.935. Which is slightly higher than the
previous model Adjusted R-squared:  0.9347. It's not even worth it to use all
the variables just to get that little to no boost of fitness."

"My question is, can we decide on which model to use based on these residuals
only? The residuals vary greatly so i think it might be possible.
"