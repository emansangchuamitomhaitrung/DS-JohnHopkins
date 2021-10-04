library(dplyr)
# 0. Collecting data
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
if (!file.exists('./Project-Data')){
        dir.create('./Project-Data')
        download.file(url, destfile = './Project-Data/Dataset.zip')
        unzip(zipfile='./Project-Data/Dataset.zip', exdir='./Project-Data')
}


# 1. Merges the TRAINING and the TEST sets to create one data set
# Reading files from training and test folder
x_train <- read.table('./Project-Data/UCI HAR Dataset/train/X_train.txt')  # 7352x561
y_train <- read.table('./Project-Data/UCI HAR Dataset/train/y_train.txt')  # 7352x1
subject_train <- read.table('./Project-Data/UCI HAR Dataset/train/subject_train.txt') # 7352x1

x_test <- read.table('./Project-Data/UCI HAR Dataset/test/X_test.txt')  # 2947x561
y_test <- read.table('./Project-Data/UCI HAR Dataset/test/y_test.txt')  # 2947x1
subject_test <- read.table('./Project-Data/UCI HAR Dataset/test/subject_test.txt')  # 2947x1

# Reading features and activity labels files
features <- read.table('./Project-Data/UCI HAR Dataset/features.txt')
activity <- read.table('./Project-Data/UCI HAR Dataset/activity_labels.txt')

## Idea: After collecting the data, we can see that the data files in the training set are of the same row-number (7353)
## Thus we can use cbind to merge the data sets in the traning set. Afterwards, we obtain a data set of the shape 7353x563 
## Similarly, the merge date set for the test set has the shape of 2947x563 
## Finally, use rbind() function to merge the entire given set (with shape=10299x563) thus 10299 observations over 561 features
## Two other variables are: ActivityID [1,6] and SubjectID [1,30]
## Note: Order in cbind() and rbind() matters!

# Merging files in test set and training set
merged_train <- cbind(subject_train, y_train, x_train)  # 7352x563
merged_test <- cbind(subject_test, y_test, x_test)  # 2947x563

merged_dat <- rbind(merged_train, merged_test)  # Merging all data and training sets, dim(merged_dat) = 10299x563


# 2. Extracts only the measurements on the MEAN and STANDARD DEVIATION for each measurement
## Idea: Get index of satisfied columns (using grepl())

# Naming the variables in the merged data set
colnames(merged_dat)[3:563] <- as.character(features[,2])
colnames(merged_dat)[1:2] <- c('SubjectID', 'Activity')
# Extract mean and SD measurement (variable), not taking mean frequency into consideration
col_index <- colnames(merged_dat)
mean_sd_index <- (grepl('-mean\\(\\)', col_index) | grepl('-std\\(\\)', col_index) 
                  | grepl('Activity', col_index) | grepl('Subject', col_index))

mean_sd <- merged_dat[, mean_sd_index==TRUE]  # 10299x68


# 3. Uses descriptive activity names to name the activities in the data set;
# Replace ActivityID with correspoding Activity type
colnames(activity)[1:2] <- c('Activity', 'ActivityType')
mean_sd$Activity <- activity$ActivityType[mean_sd$Activity]  # 10299x68

# 4. Appropriately labels the data set with descriptive variable names. 
col_names <- names(mean_sd)
col_names <- gsub('mean', 'Mean', col_names)
col_names <- gsub('std', 'Std', col_names)
col_names <- gsub('^t', 'time', col_names)
col_names <- gsub('^f', 'frequency', col_names)
names(mean_sd) <- col_names


# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## Idea: There are 30 subjects with 6 activity labels each, thus the new tidy data set should have 180 rows and 68 columns
tidy_dataset <- aggregate(.~ SubjectID + Activity, data=mean_sd, FUN=mean)
tidy_dataset <- tidy_dataset[order(tidy_dataset$SubjectID, tidy_dataset$Activity),]  # Group by subject first

# Write output
write.table(tidy_dataset, file='tidyDataset.txt', row.names = FALSE)
