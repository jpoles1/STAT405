library(caret)
set.seed(333)
#Import Data
data(faithful)
#Create Train + Test Sets
trainingIndex = createDataPartition(y=faithful$waiting, p=.5, list=FALSE)
training = faithful[trainingIndex,]
#Linear Regression
plot(training$waiting, training$eruptions)
reg = lm(eruptions~., data=training)
abline(reg)
#Training Error
sqrt(sum((reg$fitted.values-training$eruptions)^2))
#Testing
testing = faithful[-trainingIndex,]
plot(testing$waiting, testing$eruptions)
abline(reg)
#Testing Error
sqrt(sum((predict(reg, newdata=testing)-testing$eruptions)^2))
