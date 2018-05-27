# Creating a folder within the WD and downloading the file
if(!file.exists("./Project")) {dir.create("./Project")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./Project/SGalaxy.zip")
library(dplyr)

# Unzipping the files
zipF <- "./Project/SGalaxy.zip"
unzip(zipF)

# Chaning Wd to the appropriate one
setwd("./Project/UCI HAR Dataset")

# Loading the Train datasets
trainData <- read.table("./train/X_train.txt")
trainActivity <- read.table("./train/y_train.txt")
trainSubject <- read.table("./train/subject_train.txt")

# Loading the Test datasets
testData <- read.table("./test/X_test.txt")
testActivity <- read.table("./test/y_test.txt")
testSubject <- read.table("./test/subject_test.txt")

# Merging the datasets by subject, label and set of variables
mergedData <- rbind(trainData, testData)
mergedActivity <- rbind(trainActivity, testActivity) %>%
  rename(ActivityName = V1)
mergedSubject <- rbind(trainSubject, testSubject) %>%
  rename(SubjectNum = V1)

# Extracting only the variables containing mean and standard deviation measurements
features <- read.table("features.txt") %>%
  rename(featureNum = V1, featureName = V2)
MeanStd <- grep("mean\\(\\)|std\\(\\)", features[, 2])
mergedData <- mergedData[, MeanStd]
names(mergedData) <- gsub("\\(\\)", "", features[MeanStd, 2])
names(mergedData) <- gsub("std", "Std", names(mergedData))
names(mergedData) <- gsub("mean", "Mean", names(mergedData))
names(mergedData) <- gsub("-", "", names(mergedData))
head(mergedData)

# Naming the activities
Activities <- read.table("activity_labels.txt")
Activities[, 2] <- tolower(gsub("_", "", Activities[, 2]))
mergedActivity[,1] <- Activities[mergedActivity[,1],2]
head(mergedActivity)

# Merging the datasets
TidyData <- cbind(mergedSubject, mergedActivity, mergedData)
head(TidyData)

# Saving the cleaned data
write.table(TidyData, "Tidy_Data.txt", row.names = FALSE)

# Creating independent tidy data set with the average of each variable for each activity and each subject 
TidyData_AVG <- aggregate(mergedData, by = list(TidyData$ActivityName, TidyData$SubjectNum), mean)
head(TidyData_AVG)
write.table(TidyData_AVG, "Tidy_Data_Averages.txt", row.names = FALSE)

