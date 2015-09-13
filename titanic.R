library(caret)
require(randomForest)
data = read.csv("titanictrain.csv")
data$Cabin = NULL
data$Ticket = NULL
data$Name = NULL
data = data[complete.cases(data),]
#Data Exploration
predictors = data[,3:9]
survival = data[,2]
plot(predictors$Age, survival)
boxplot(predictors$Fare)
plot(predictors$Fare, survival)
#Setup Dummy Variables
dummies = dummyVars(Survived~., data)
predict(dummies, newdata=data)
