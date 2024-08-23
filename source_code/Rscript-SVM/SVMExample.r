args <- commandArgs(TRUE)
trainingFile <- args[1]
testFile <- args[2]


visitdata <- read.table(trainingFile, header=TRUE, sep=",")
testdata <- read.table(testFile, header=TRUE, sep=",")

colnum <- length(visitdata)
rownum <- nrow(visitdata)
att <- names(visitdata)
print("attributes")
print(att)
print(paste ("colunm number = ", colnum))
print(paste ("row number = ", rownum))

classLabelColNo <- colnum
halfpoint <- as.integer(rownum/2)

######################################################
# prepare data (training, testing)
trn_visitdata <- visitdata
#tst_visitdata <- visitdata[(halfpoint+1):rownum,]
tst_visitdata <- testdata
nrow(trn_visitdata)
nrow(tst_visitdata)

trn_visitdata_data <- trn_visitdata[,-classLabelColNo]
trn_visitdata_classlabel <- trn_visitdata[,classLabelColNo]
nrow(trn_visitdata_data)
length(trn_visitdata_data)

tst_visitdata_data <- tst_visitdata[,-classLabelColNo]
tst_visitdata_classlabel <- tst_visitdata[,classLabelColNo]
nrow(tst_visitdata_data)
length(tst_visitdata_data)
######################################################
## SVM approach
library(e1071) 
#the below one does not work (rough check)
#svm_model<-svm(trn_visitdata_data, trn_visitdata_classlabel, type="C-classification") 
#print(svm_model)
#summary(svm_model)
#print(svm_model$index)
#svm_pred <- predict(svm_model, tst_visitdata_data) 

library(kernlab)
#ksvm_model <- ksvm(trn_visitdata_classlabel~.,data=trn_visitdata_data,type="C-bsvc",kernel=rbfdot,C=10,prob.model=TRUE) 
#the above kernel does not work

ksvm_model <- ksvm(trn_visitdata_classlabel~.,data=trn_visitdata_data,type="C-bsvc",C=10,prob.model=TRUE)

#Using automatic sigma estimation (sigest) for RBF or laplace kernel 
#the model leaning takes more than 2 minutes in Yifan computer

ksvm_pred <- predict(ksvm_model, tst_visitdata_data) 
table(ksvm_pred, tst_visitdata_classlabel)

#output
#tst_visitdata_classlabel
#ksvm_pred    0    1
#0   66  179
#1 1063 8628
sum(ksvm_pred==tst_visitdata_classlabel)/length(tst_visitdata_classlabel)
#0.875

