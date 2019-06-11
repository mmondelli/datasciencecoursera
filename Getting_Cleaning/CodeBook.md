# CodeBook

This code book describes the data and its variables, as well as the transformations applied to perform the analysis.

## The data source

In this project, we analyze data collected from the accelerometers from the Samsung Galaxy S smartphone. 

You can find the original data set [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Its description and details can be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data set includes the following files:

- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

## Transformation steps 

Before starting the transformation steps, at the beginning of the ```run_analysis.R``` script we perform some configurations such as loading the required packages, downloading and reading the data set.

Then the transformations are organized into 5 mains steps, described as follows:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.







