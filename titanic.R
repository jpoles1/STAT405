library(caret)
require(randomForest)
library(doMC)
registerDoMC(cores = 8)
traindata = read.csv("titanictrain.csv")
traindata$Cabin = NULL
traindata$Ticket = NULL
traindata$Name = NULL
traindata$Survived = as.factor(traindata$Survived)
traindata = traindata[complete.cases(traindata),]

#Data Exploration
predictors = traindata[,3:9]
survival = traindata[,2]
plot(predictors$Age, survival)
boxplot(predictors$Fare)
plot(predictors$Fare, survival)

#Setup Dummy Variables
#dummies = dummyVars(Survived~., traindata)
#predict(dummies, newdata=traindata)

#Random Forest
forest = train(Survived~., data=traindata, method="rf", prox=TRUE, preProcess = c("BoxCox", "knnImpute"))
#Testing
testdata = read.csv("titanictest.csv")
testdata$Name = NULL
testdata$Cabin = NULL
testdata$Ticket = NULL
predictions = predict(forest, testdata)
length(predictions)
submit <- data.frame(PassengerId = testdata$PassengerId, Survived = predict(forest, testdata))
write.csv(submit, file = "firstforest.csv", row.names = FALSE)