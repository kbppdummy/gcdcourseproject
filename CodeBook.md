# Course Project Code Book

## Introduction

This code book explains the data set created by the R scripts in this GitHub repository <insert link here>, what transformations are made to produce the data, and how the scripts are related to each other.

This code book is created as a requirement to the course project of the Coursera course _Getting and Cleaning Data_.

## Variables

### First Data Set
Below is a list of the variables the the script will produce. Those with the form name.XYZ has three forms: name-X, name-Y, and name-Z.
 - subject.id
 	- the id corresponding to each subject
 - time.BodyAcc.mean.XYZ
 	- mean of body accelaration for X,Y,Z coordinates (time domain signal)
 - time.GravityAcc.mean.XYZ
 	- mean of gravity acceleration for X,Y,Z coordinates (time domain signal)
 - time.BodyAccJerk.mean.XYZ
 	- mean of body acceleration jerk for X,Y,Z coordinates (time domain signal)
 - time.BodyGyro.mean.XYZ
 	- mean of body gyroscope signal for X,Y,Z coordinates (time domain signal)
 - time.BodyGyroJerk.mean.XYZ
 	- mean of body gyroscope signal jerk for X,Y,Z coordinates (time domain signal)
 - time.BodyAccMag.mean
 	- mean of the magnitude of body acceleration
 - time.GravityAccMag.mean
 	- mean of the magnitude of gravity acceleration
 - time.BodyAccJerkMag.mean
 	- mean of the magnitude of body acceleration jerk
 - time.BodyGyroMag.mean
 	- mean of the magnitude of body gyroscope signal
 - time.BodyGyroJerkMag.mean
 	- mean of magnitude of the body gyroscope signal jerk
 - frequency.BodyAcc.mean.XYZ
 	- mean of body acceleration for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyAccJerk.mean.XYZ
 	- mean of body acceleration jerk for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyGyro.mean.XYZ
 	- mean of body gyroscope signal for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyAccMag.mean
 	- mean of the magnitude of body acceleration 
 - frequency.BodyBodyAccJerkMag.mean
 	- mean of the magnitude of body acceleration jerk
 - frequency.BodyBodyGyroMag.mean
 	- mean of the magnitude of body gyroscope signal
 - frequency.BodyBodyGyroJerkMag.mean
 	- mean of the magnitude of the body gyroscope signal jerk
 - time.BodyAcc.std.XYZ
 	- standard deviation of body acceleration for X,Y,Z coordinates (time domain signal)
 - time.GravityAcc.std.XYZ
 	- standard deviation of gravity acceleration for X,Y,Z coordinates (time domain signal)
 - time.BodyAccJerk.std.XYZ
 	- standard deviation of body acceleration jerk for X,Y,Z coordinates (time domain signal)
 - time.BodyGyro.std.XYZ
 	- standard deviation of body gyroscope signal for X,Y,Z coordinates (time domain signal)
 - time.BodyGyroJerk.std.XYZ
 	- standard deviation of body gyroscope signal jerk for X,Y,Z coordinates (time domain signal)
 - time.BodyAccMag.std
 	- standard deviation of the magnitude of body acceleration
 - time.GravityAccMag.std
 	- standard deviation of the magnitude of gravity acceleration
 - time.BodyAccJerkMag.std
 	- standard deviation of the magnitude of body acceleration jerk
 - time.BodyGyroMag.std
 	- standard deviation of the magnitude of body gyroscope signal
 - time.BodyGyroJerkMag.std
 	- standard deviation of magnitude of the body gyroscope signal jerk
 - frequency.BodyAcc.std.XYZ
 	- standard deviation of body acceleration for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyAccJerk.std.XYZ
 	- standard deviation of body acceleration jerk for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyGyro.std.XYZ
 	- standard deviation of body gyroscope signal for X,Y,Z coordinates (frequency domain signal)
 - frequency.BodyAccMag.std
 	- standard deviation of the magnitude of body acceleration
 - frequency.BodyBodyAccJerkMag.std
 	- standard deviation of the magnitude of body acceleration jerk
 - frequency.BodyBodyGyroMag.std
 	- standard deviation of the magnitude of body gyroscope signal
 - frequency.BodyBodyGyroJerkMag.std
 	- standard deviation of the magnitude of the body gyroscope signal jerk
 - activity
    - the type of activity being executed when these measurements are collected

### Second Data Set
The second data set inherits the same variable names as that of the first data set, prefixing all variables except for subject.id and activity with the phrase Average.of.

As the prefix states, all variables with the prefix is just the mean of the measurements from the first data set. They are, however, averaged by activity and subject.

## Data Processing

The original data has 561 features, while this set of data only contains 68 features.

The only measurements extracted from the original data were the values that computed for the mean and standard deviation of the raw measurement. There are 33 features for both. The remaining two features added were subject.id and activity.

The following steps were followed when the data was processed:
	1. Except for the Inertial Signals folder, every file in the test and train folder were read. The Inertial Signals folder was ignored since we are only interested in the values computed using mean and standard deviation, and the said folder does not contain any of the said values.
	2. Once read, the columns corresponding to mean and standard deviation values were extracted from the original data. This is done by selecting the columns with the keywords _.mean._ and _.std._ as variable name. Variable name preprocessing allowed the periods to be placed before and after the keywords (See cleanVariableNames function in functions.R).
	3. After extraction, they are merged to create all the observations. Creating a total of 10299 observations. Simple cbind and rbind functions were used for this.
	4. The output data frame was saved into a .csv file named merged.csv. (It was not specified whether it should be printed or returned, thus I saved it in a file which can later be read.)
	5. A second independent data set was created. It contains the average of all features as grouped by their corresponding activity and subject. This was done by using the group_by function on the first output data, grouping the data by activity and subject.id. The averages were computed using the summarize_all function, applying the mean function to all non-group variables.

## R Scripts

The Github repository contains three (3) R scripts:
	1. run_analysis.R
		This is the main script. It contains one (1) function which must be called to invoke the other functions.
		It initiates the flow of the analysis and initializes whichever files/libraries are needed for the analysis.
	2. merge.R
		This contains one (1) function which is the main task at hand: merging the train and test data sets. This contains the bulk of the task. This calls most of the functions in functions.R
	3. functions.R
		This is the helper script which contains six (6) functions which can be called by run_analysis.R and merge.R.