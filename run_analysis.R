## Scripts for Getting and Cleaning Data course project

##load libraries
library(dplyr)
library(stringr)
library(reshape2)
##-----------------------------------FILE PREPARATION------------------------------------

##!!!!!!!!!!!!!!!!must enter the path for the directory with unzipped data files!!!!!!!!!

## Directory path for test files
testDirPath <- 'your-directory' 
## Directory path for train files
trainDirPath <- 'your-directory'
## Directory path for feature files
featureDirPath <- 'your-directory'

##---------------------------------READING DATA-----------------------------------------
## Reading test files
xTest <- read.table(file = paste(testDirPath,'X_test.txt', sep = ''), header = FALSE)

yTest <- read.table(file = paste(testDirPath,'y_test.txt', sep = ''), header = FALSE)

subject_test <- read.table(file = paste(testDirPath,'subject_test.txt', sep = ''), header = FALSE)


## Reading train files
xTrain <- read.table(file = paste(trainDirPath,'X_train.txt', sep = ''), header = FALSE)

yTrain <- read.table(file = paste(trainDirPath,'y_train.txt', sep = ''), header = FALSE)

subject_train <- read.table(file = paste(trainDirPath,'subject_train.txt', sep = ''), header = FALSE)


## Reading feature files
feature <- read.table(file = paste(featureDirPath, 'features.txt', sep = ''), header = FALSE)
colnames(feature) <- c('№', 'activity')
activityLbl <- read.table(file = paste(featureDirPath, 'activity_labels.txt', sep = ''), header = FALSE)
colnames(activityLbl) <- 'activity'

##-----------------------------TRANSFORMING DATA-----------------------------------------
## Extracting mean & std features
selectedCols <- grep("-(mean|std).*", as.character(feature$activity))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)

##Combine test and train files
xData <- rbind(xTest, xTrain)
yData <- rbind(yTest, yTrain)
sData <- rbind(subject_test, subject_train)

## Extracting activity measurment data by mean & std features
xData <- xData[selectedCols]

## Merging data & adding descriptive names
cData <- cbind(sData, yData, xData)
colnames(cData) <- c('subject', 'activity', selectedColNames)

cData$activity <- factor(cData$activity, levels = activityLbl[,1], labels = activityLbl[,2])
cData$subject <- as.factor(cData$subject)

## Generating tidy dataset
meltedData <- melt(cData, id = c('subject', 'activity'))
tidyData <- dcast(meltedData, subject + activity ~ variable, mean)
write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)