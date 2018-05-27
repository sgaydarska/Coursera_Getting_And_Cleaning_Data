# Getting and Cleaning Data Peer Assignment Code Book

## The data

The data for this project is sourced out of: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

It contains training and testing datasets in text files split by features("X_test.txt" and "X_train.txt"), activities ("y_test.txt" and "y_train.txt") and subjects ("subject_test.txt" and "subject_train.txt"). Additionally, the names of the activities come from the "activity_labels.txt" file and the corresponding features from "features.txt" file.

Please read the "README.txt" and "features_info.txt" after unzipping the .zip file to have more detailed information regarding the experiment, the data and its correponding features.

## The run_analysis.R script

The R script performs the following actions:

1. Creates a "Project" directory where it unzpis the .zip file in a folder called "UCI HAR Dataset". Afterwards, it sets the working directory to the latter folder where all the text files have been extracted. 

2. Reads the training and testing datasets and joins them based on the containing data to create the following 3 data sets:
   - mergedData with dimensions: 10299 x 561 that joins the testing and training features files
   - mergedActivities with dimensions: 10299 x 1 that joins the  testing and training activities files. The only column "V1" is renamed to "ActivityName".
   - mergedSubjects with dimensions: 10299 x 1that joins the testing and training subject files. The only column "V1" is renamed to "SubjectNum". We have 30 subjects as 30 people have participated in the experiment. 
   
3. Reads and stores the features text file and based on it extracts only the variables that measure the mean or standard deviations which results in subsetting for 66 variables out of 561. To make the variable naming better it removes the "()" and "-" symbols and capitalizes the "S" in std and "M" in mean.

4. Reads and stores the activities text file and applies the 6 descriptive activity names to the mergedActivities dataset. It also sets the names to be only lowercase for better readability. The activities we're working with are:
```
walking
walkingupstairs
walkingdownstairs
sitting
standing
laying.
```
  
 5. Joins the 3 merged datasets in one tidy dataset called TidyData with dimensions 10299 x 68. We have the SubjectNum, ActivityName and the only 66 variables that measure the mean and standard devation as described in step 3. The script also saves the cleaned data in a file called "Tidy_Data.txt"
 
 6. Creates a second independent clean data set called TidyData_AVG based on the TidyData where it calculates the average of each variable for each activity and each subject. We use the aggregate function to create the new TidyData_AVG and use the mean function to calculate the averages. The script also saves the new data set in a text file called "Tidy_Data_Avegares.txt".
 
Please use functions such as summary(), str(), glimpse() etc. to take a look at the variables, their contents, values and summary statistics for the TidyData and TidyData_AVG datasets. 

