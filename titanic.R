library(caret)
library(doMC)
library(plyr)
registerDoMC(cores = 8)
#Fetch Raw Data 
rawdata = read.csv("titanictrain.csv")
#Preprocess Data
rawdata$Cabin = NULL
rawdata$Ticket = NULL
rawdata$Name = NULL
rawdata$Survived = as.factor(rawdata$Survived)
rawdata = rawdata[complete.cases(rawdata),]
#Split Data
inValid = createDataPartition(rawdata$Survived, p=0.4, list=FALSE)
validdata = rawdata[inValid,]
traindata = rawdata[-inValid,]
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
forest = train(Survived~., data=traindata, method="rf", prox=TRUE, preProcess = c("BoxCox"))
#Boosting
booster = train(Survived~., data=traindata, method="gbm", prox=TRUE, preProcess = c("BoxCox"))
#Validation
predictions = predict(forest, validdata);
validation = cbind(validdata, data.frame(pred1=predictions, truth=predictions==validdata$Survived))
confusionmatrix = table(validation$Survived, validation$pred1)
cat("Accuracy:", 100*sum(diag(confusionmatrix))/sum(confusionmatrix), "%")
#Testing
testdata = read.csv("titanictest.csv")
testdata$Name = NULL
testdata$Cabin = NULL
testdata$Ticket = NULL
predictions = predict(forest, testdata)
length(predictions)
submit <- data.frame(PassengerId = testdata$PassengerId, Survived = predict(forest, testdata))
write.csv(submit, file = "firstforest.csv", row.names = FALSE)