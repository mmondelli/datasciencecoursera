# Installing/loading packages #####

if (!require("data.table")) { install.packages("data.table") }
if (!require("reshape2")) { install.packages("reshape2") }
if (!require("dplyr")) { install.packages("dplyr") }

lapply(c('data.table', 'reshape2', 'dplyr'), FUN = require, character.only = TRUE)

# 0. Download the data

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile = 'uci_har_dataset.zip')
unzip('uci_har_dataset.zip')
list.files('./UCI HAR Dataset/')

# Setting working directory
setwd('./UCI HAR Dataset/')

## 1. Merges the training and the test sets to create one data set. #####

# Read the files and edit the names

features <- read.table('features.txt')

x_test <- read.table('./test/X_test.txt'); names(x_test) <- features
x_train <- read.table('./train/X_train.txt')
subject_train <- read.table('./train/subject_train.txt')

y_test <- read.table('./test/y_test.txt')
y_train <- read.table('./train/y_train.txt')
subject_test <- read.table('./test/subject_test.txt')

names(x_test) <- names(x_train) <- features$V2
names(y_test) <- names(y_train) <- 'activity_id'
names(subject_test) <- names(subject_train) <- 'subject'

# Combine test dataframes
test <- data.frame(y_test, x_test, subject_test)

# Combine train dataframes
train <- data.frame(y_train, x_train, subject_train)

# Merge the two previous dataframes
merged <- rbind(test, train)

# Remove dataframes that will not be used anymore
rm(test, train, x_test, x_train, y_test, y_train, subject_test, subject_train)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement. #####

# Get the features for std and mean measurements (and keep the subject and activity_labe columns)
mean_std_features <- grep('mean()|std()|subject|activity_id', names(merged))

# Extract only these features from the merged dataframe
merged_filtered <- merged[,mean_std_features]

## 3. Uses descriptive activity names to name the activities in the data set #####

activity_labels <- read.table('activity_labels.txt')
colnames(activity_labels) <- c('activity_id', 'activity_label')

## 4. Appropriately labels the data set with descriptive variable names. #####

merged_filtered <- merge(merged_filtered, activity_labels)

## 5. From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject. #####

tidy <- merged_filtered %>%
  group_by(subject, activity_label) %>%
  summarise_each(list(mean))

# Save the tidy dataframe
write.table(tidy, file="../tidy_output.txt", row.name=FALSE)

