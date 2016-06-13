library(reshape2)

#Set working dir
setwd("~/coursera/GettingAndCleaningDataWeek4")

fileName <- "getdata_dataset.zip"

# Download the dataset if not already exists
if (!file.exists(fileName)){
  f_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(f_URL, fileName, method="curl")
}  

# Unzip the dataset if not already done
if (!file.exists("UCI HAR Dataset")) { 
  unzip(fileName) 
}

# Identify the desired features and activities
featuresDesired <- c(1, 2, 3, 4, 5, 6, 41, 42, 43, 44, 45, 46, 81, 82, 83, 84, 85, 86, 121, 122, 123, 124, 125, 126, 161, 162, 163, 164, 165, 166, 201, 202, 214, 215, 227, 228, 240, 241, 253, 254, 266, 267, 268, 269, 270, 271, 345, 346, 347, 348, 349, 350, 424, 425, 426, 427, 428, 429, 503, 504, 516, 517, 529, 530, 542, 543)
featuresDesiredNames <- c("tBodyAcc-mean()-X", "tBodyAcc-mean()-Y", "tBodyAcc-mean()-Z", "tBodyAcc-std()-X", "tBodyAcc-std()-Y", "tBodyAcc-std()-Z", "tGravityAcc-mean()-X", "tGravityAcc-mean()-Y", "tGravityAcc-mean()-Z", "tGravityAcc-std()-X", "tGravityAcc-std()-Y", "tGravityAcc-std()-Z", "tBodyAccJerk-mean()-X", "tBodyAccJerk-mean()-Y", "tBodyAccJerk-mean()-Z", "tBodyAccJerk-std()-X", "tBodyAccJerk-std()-Y", "tBodyAccJerk-std()-Z", "tBodyGyro-mean()-X", "tBodyGyro-mean()-Y", "tBodyGyro-mean()-Z", "tBodyGyro-std()-X", "tBodyGyro-std()-Y", "tBodyGyro-std()-Z", "tBodyGyroJerk-mean()-X", "tBodyGyroJerk-mean()-Y", "tBodyGyroJerk-mean()-Z", "tBodyGyroJerk-std()-X", "tBodyGyroJerk-std()-Y", "tBodyGyroJerk-std()-Z", "tBodyAccMag-mean()", "tBodyAccMag-std()", "tGravityAccMag-mean()", "tGravityAccMag-std()", "tBodyAccJerkMag-mean()", "tBodyAccJerkMag-std()", "tBodyGyroMag-mean()", "tBodyGyroMag-std()", "tBodyGyroJerkMag-mean()", "tBodyGyroJerkMag-std()", "fBodyAcc-mean()-X", "fBodyAcc-mean()-Y", "fBodyAcc-mean()-Z", "fBodyAcc-std()-X", "fBodyAcc-std()-Y", "fBodyAcc-std()-Z", "fBodyAccJerk-mean()-X", "fBodyAccJerk-mean()-Y", "fBodyAccJerk-mean()-Z", "fBodyAccJerk-std()-X", "fBodyAccJerk-std()-Y", "fBodyAccJerk-std()-Z", "fBodyGyro-mean()-X", "fBodyGyro-mean()-Y", "fBodyGyro-mean()-Z", "fBodyGyro-std()-X", "fBodyGyro-std()-Y", "fBodyGyro-std()-Z", "fBodyAccMag-mean()", "fBodyAccMag-std()", "fBodyBodyAccJerkMag-mean()", "fBodyBodyAccJerkMag-std()", "fBodyBodyGyroMag-mean()", "fBodyBodyGyroMag-std()", "fBodyBodyGyroJerkMag-mean()", "fBodyBodyGyroJerkMag-std()")
activities <- c(1, 2, 3, 4, 5, 6)
activityNames <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")


# Load the training dataset, subject and activities and merge them
trainingDS <- read.table("UCI HAR Dataset/train/X_train.txt")[featuresDesired]
trainingActivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
trainingDS <- cbind(trainingSubjects, trainingActivities, trainingDS)

# Load the test dataset, subject and activities and merge them
testDS <- read.table("UCI HAR Dataset/test/X_test.txt")[featuresDesired]
testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
testDS <- cbind(testSubjects, testActivities, testDS)

# Merge both the training and test datasets and label the columns
mergedDS <- rbind(trainingDS, testDS)
colnames(mergedDS) <- c("subject", "activity", featuresDesiredNames)

# Convert activities & subjects into factors
mergedDS$activity <- factor(mergedDS$activity, levels = activities, labels = activityNames)
mergedDS$subject <- as.factor(mergedDS$subject)

# Melt the data set to facilitate the calculation of the mean
mergedDS.melted <- melt(mergedDS, id = c("subject", "activity"))
mergedDS.mean <- dcast(mergedDS.melted, subject + activity ~ variable, mean)

#Write this dataset
write.table(mergedDS.mean, "tidy.txt", row.names = FALSE, quote = FALSE)
