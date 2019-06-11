# Installing/loading packages #####

if (!require("data.table")) { install.packages("data.table") }
if (!require("reshape2")) { install.packages("reshape2") }

lapply(c('data.table', 'reshape2'), FUN = require, character.only = TRUE)

# 0. Download the data

download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile = 'uci_har_dataset.zip')
unzip('uci_har_dataset.zip')
list.files('./uci_har_dataset')

# 1. Merges the training and the test sets to create one data set. #####

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. #####
# 3. Uses descriptive activity names to name the activities in the data set #####
# 4. Appropriately labels the data set with descriptive variable names. #####
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. #####