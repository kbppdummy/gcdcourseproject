#
#   functions.R
#   Code Description:
#       This contains most helper functions for merge.R and run_analysis.R
#       Created for a Coursera Course Project.

#extracts the features that contains averages of each measurement
#this does not include the mean frequency since it was stated to get only the mean of each measurement
#   and mean frequency computes for the *weighted values* of the measurement
getMeanAndStd <- function(X_test, X_train){
  #reading the names of all of the features from the given text file
  features <- read.table("./data/features.TXT")
  features <- features[,2] #removes the feature number
  features <- cleanVariableNames(features) #makes the variable names more readable
  
  names(X_test) <- features #renames the columns with the read features
  names(X_train) <- features
  
# NOTE: 
# I edited the features.txt file since there are duplicated names (in all bandsEnergy() variables).
# I just added a -X, -Y, or -Z at the end since they are all duplicated thrice.

  temp1 <- select(X_test, contains(".mean.")) #gets all variables that used mean
  temp2 <- select(X_test, contains(".std.")) #gets all standard deviations
  X_test <- cbind(temp1,temp2) #for test data
  
  temp1 <- select(X_train, contains(".mean."))
  temp2 <- select(X_train, contains(".std."))
  X_train <- cbind(temp1, temp2) #for train data
  
  list(X_test, X_train) #returns the data in a list so it can be extracted later on
}#end of getMeandAndStd function

#makes the variable names more readable
cleanVariableNames <- function(feat){
  feat <- gsub("-",".",feat) #removes dashes (since it is not processed by select)
  feat <- gsub("\\(", ".", feat) #removes excess parentheses
  feat <- gsub("\\)", ".", feat)
  feat <- gsub(",", ".", feat) #removes comma
  #everything is replaced by a period
  feat
}#end of cleanVariableNames function

#renames the variable names (tries to make them better)
makeAppropriateNames <- function(varnames){
  print("Renaming variable names...", quote = FALSE)
  print("", quote = FALSE)
  temp <- varnames[2:(length(varnames)-1)]
  
  temp <- sub("^t","time",temp)
  temp <- sub("^f","frequency",temp)
  temp <- sub("BodyBody","Body.",temp)
  temp <- sub("Acc","Acceleration.",temp)
  temp <- sub("Mag","Magnitude.",temp)
  temp <- sub("Jerk","Jerk.",temp)
  temp <- sub("Gyro","Gyroscope.",temp)
  temp <- sub("Gravity","Gravity.",temp)

  temp1 <- grepl("\\.mean",temp)
  temp[temp1] <- paste0("Mean.of.",temp[temp1])
  temp[temp1] <- sub("\\.mean","",temp[temp1])
  temp1 <- grepl("\\.std",temp)
  temp[temp1] <- paste0("Standard.Deviation.of.",temp[temp1])
  temp[temp1] <- sub("\\.std","",temp[temp1])
  temp <- sub("\\.\\.\\.","",temp)
  temp <- tolower(temp)
  
  varnames[2:(length(varnames)-1)] <- temp  
  print("   RENAMING COMPLETE.", quote = FALSE)
  print("", quote = FALSE)

  varnames
}#end of makeAppropriateNames function

#converts the numeric values of activity into its word equivalent
changeActivityNames <- function(merged){
  for(i in 1:length(merged[,1])){
    merged[i,"activity"] <- convertY(merged[i,"activity"])
  }
  merged
}#end of changeActivityName function

#returns the equivalent for each numeric value
convertY <- function(Y){
  if(Y == 1) Y <- "walking"
  else if(Y == 2) Y <- "walking upstairs"
  else if(Y == 3) Y <- "walking downstairs"
  else if(Y == 4) Y <- "sitting"
  else if(Y == 5) Y <- "standing"
  else Y <- "laying"
  Y
}#end of convertY function

#function to create the second data set
createSecondDataSet <- function(merged){
  #the data is grouped by activity and subject.id
  merged <- group_by(merged, activity, subject.id)

  #and to get the mean of all variables based on the grouping,
  #summarize_all is used.
  #summarize_all will, in the case of the code below, will use the mean function to all variables
  #   that is not the grouping variable (i.e., activity, subject.id)
  newData <- summarize_all(merged, mean)
  
  variables <- names(newData)
  for(i in 3:length(variables)){
    variables[i] <- paste0("Average.of.",variables[i])
  }
  
  names(newData) <- variables

  newData
}#end of createSecondDataSet function

#end of file