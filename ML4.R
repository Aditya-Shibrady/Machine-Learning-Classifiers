args <- commandArgs(TRUE)
dataURL<-as.character(args[1])
header<-as.logical(args[2])
d<-read.csv(dataURL,header = header)
int<-as.integer(args[3])

library(rpart)
library(e1071) 
library(class)
library("neuralnet")
library(mlbench)
library(ada)
library(randomForest)
library(neuralnet)
library(nnet)
library(ipred)
sumtree<-0
sumsvm <-0
sumnb <-0
sumlog <-0
sumrd <-0
sumneu <-0
sumboost <-0
sumbag <-0
sumknn <-0

# Creating Samples
set.seed(123)
for(i in 1:10) {
cat("Performing calculations on Sample Set ",i,"\n")
sampleInstances<-sample(1:nrow(d),size = 0.9*nrow(d))
trainingData<-d[sampleInstances,]
trainingData <-na.omit(trainingData)
testData<-d[-sampleInstances,]
testData <-na.omit(testData)
  
Class<-as.factor(as.integer(args[3]))
class1 <- as.integer(args[3])
testClass <- testData[,as.integer(int)]
  
# Creating Classifiers

# Decision Tree
method <-"DecisionTree"
modeldecision <- rpart(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")),data=trainingData,parms = list(split = "information"), method = "class", minsplit = 1)
prunedTree <- prune(modeldecision, cp = 0.010000)
predictTree <- predict(prunedTree,testData,type="class")
treeacctable <- table(predictTree,testClass)
treeaccuValue <- sum(diag(treeacctable))/sum(treeacctable) *100
sumtree <- sumtree +treeaccuValue
cat("Method = ", method,", accuracy= ", treeaccuValue,"\n")
  
#SVM
method <- 'SVM'
#modelsvm <- svm(classform, data = trainingData)
modelsvm <- svm(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")),data = trainingData)
predsvm <- predict(modelsvm, testData, type = "class")
svmtable <- table(predsvm,testClass)
svmaccuracy <- sum(diag(svmtable))/sum(svmtable) *100
sumsvm <- sumsvm +svmaccuracy
cat("Method = ", method,", accuracy= ", svmaccuracy,"\n")
  
#Naive Bayes
method <- 'NaiveBayes'
nbmodel <- naiveBayes(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), data = trainingData)
prednb <- predict(nbmodel, testData, type = "class")
nbacctable <- table(prednb,testClass)
nbaccvalue <- sum(diag(nbacctable))/sum(nbacctable) *100
sumnb <- sumnb + nbaccvalue
cat("Method = ", method,", accuracy= ", nbaccvalue,"\n")
  
#Logistic Regression
method <- 'Logistic Regression'
logisticModel <- glm(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), data = trainingData, family = "binomial")
predlogistic<-predict(logisticModel, newdata=testData, type="response")
threshold=0.65
prediction<-sapply(predlogistic, FUN=function(x) if (x>threshold) 1 else 0)
actual<-d[,as.integer(int)]
LRaccvalue <- sum(actual==prediction)/length(actual) *100
sumlog <- sumlog+LRaccvalue
cat("Method = ", method,", accuracy= ", LRaccvalue,"\n")
  
#Random Forest
method <- "RandomForest"
rfModel <- randomForest(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), data=trainingData, importance=TRUE, proximity=TRUE, ntree=500)
RFpred <- predict(rfModel,testData,type='response')
predTable <- table(RFpred,testClass)
accuracy <- sum(diag(predTable))/sum(predTable)*100
sumrd <- sumrd+accuracy
cat("Method = ", method,", accuracy= ", accuracy,"\n")
  
#Neural Network
method <- 'Neural'
nnetmodel <- nnet(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), trainingData,size=1)
pred <- predict(nnetmodel, testData)
neural <- table(pred,testClass)
accuracy <- sum(diag(neural))/sum(neural) *100
sumneu <- sumneu+accuracy
cat("Method = ", method,", accuracy= ", accuracy,"\n")
  
#Boosting
method <- 'Boosting'
model <- ada(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), data = trainingData, iter=20, nu=1, type="discrete")
p=predict(model,testData)
acc <- table(p,testClass)
accuracy <- sum(diag(acc))/sum(acc) *100
sumboost <- sumboost+accuracy
cat("Method = ", method,", error= ", accuracy,"\n")
  
#Bagging
method <- 'Bagging'
baggmodel <- bagging(as.formula(paste0("as.factor(", colnames(d)[int], ") ~ .")), data = trainingData, control = rpart.control(maxdepth=1), mfinal=1)
pred <-predict(baggmodel, testData)
acc <- table(pred,testClass)
bm=(sum(diag(acc))/sum(acc) *100)
sumbag <- sumbag+bm
cat("Method = ", method,", accuracy= ", bm,"\n")

#KNN
method <- 'KNN'
trainClass<-trainingData[,as.integer(args[3])]
knnModel<-knn(train=trainingData[,-as.integer(int)], test=testData[,-as.integer(int)], cl=trainClass, k=9, prob=TRUE)
accuknn<-mean(knnModel == testClass)*100
sumknn <- sumknn+accuknn
cat("Method = ", method,", accuracy= ", accuknn,"\n")
  
}

sumtree <- sumtree/10
sumsvm <- sumsvm/10
sumnb <- sumnb/10
sumlog <- sumlog/10
sumrd <- sumrd/10
sumneu <- sumneu/10
sumboost <- sumboost/10
sumbag <- sumbag/10
sumknn <- sumknn/10

vector <- vector("numeric",length = 10)
vector <- c(sumtree,sumsvm,sumnb,sumlog,sumrd,sumneu,sumboost,sumbag,sumknn)
table <- as.table(vector)
names(table) <-c("DecisionTree","SVM","NaviveBayes","LogisticRegression","RandomForest","NeuralNet","Boosting","Bagging","KNN")
print(table)