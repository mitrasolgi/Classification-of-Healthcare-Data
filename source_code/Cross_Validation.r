dataSet <- read.csv('Training_Validation_Merged_Cleaned_Policy_2.csv')
# datasets with show and noShow labels
dataSetY <- dataSet[dataSet["Show"]=="Y",]
dataSetN <- dataSet[dataSet["Show"]=="N",]
samplefoldsY <- cut(1:nrow(dataSetY), breaks=10, labels=F)
samplefoldsN <- cut(1:nrow(dataSetN), breaks=10, labels=F)
# Show="Y"
for(i in 1:10)
{
  Indexes <- which(samplefoldsY==i ,arr.ind=TRUE)
  # the ith fold is testing
  testSet <- dataSetY[Indexes, ]
  # all the other folds are training    
  trainSet <- dataSetY[-Indexes, ]  

  filename <- paste("TestFold_Y_",i, ".csv", sep="")
  write.table(testSet, filename, 
              col.names = FALSE, row.names = FALSE, sep = ",", quote = FALSE)
  
  filenameTrain <- paste("TrainFold_Y_",i, ".csv", sep="")
  
  write.table(trainSet, filenameTrain, col.names = FALSE,
   row.names = FALSE, sep = ",", quote = FALSE)

}
# Show="N"
for(i in 1:10)
{
    Indexes <- which(samplefoldsN==i ,arr.ind=TRUE)
    testSet <- dataSetN[Indexes, ]   # the ith fold is testing
    trainSet <- dataSetN[-Indexes, ] # all the other folds are training
    
    filename <- paste("TestFold_N_",i, ".csv", sep="")
    write.table(testSet, filename,
    col.names = FALSE, row.names = FALSE, sep = ",", quote = FALSE)
    
    filenameTrain <- paste("TrainFold_N_",i, ".csv", sep="")
    
    write.table(trainSet, filenameTrain,
    col.names = FALSE, row.names = FALSE, sep = ",", quote = FALSE)
    
}

#manually merge
#TestFold_N_i.csv and TestFold_Y_i.csv => TestFold_i.csv
#TrainFold_N_i.csv and TrainFold_Y_i.csv => TrainFold_i.csv
#
