#
#   merge.R
#   Code Description:
#       The function this file contains is the main function used by run_analysis.R.
#       Created for a Coursera Course Project.

processData <- function(){
  print("Merging the test and train data:", quote = FALSE)
  print("", quote = FALSE)
  
  #reads all the training data
  print("   Reading train data...", quote = FALSE)
  X_train <- read.table("./data/train/X_train.TXT")
  Y_train <- read.table("./data/train/y_train.TXT", col.names = c("activity"))
  subject_train <- read.table("./data/train/subject_train.TXT", col.names = c("subject.id"))
  print("   Successfully read train data.", quote = FALSE); print("", quote = FALSE)
  
  #reads all the testing data
  print("   Reading test data...", quote = FALSE)
  X_test <- read.table("./data/test/X_test.TXT")
  Y_test <- read.table("./data/test/y_test.TXT", col.names = c("activity"))
  subject_test <- read.table("./data/test/subject_test.TXT", col.names = c("subject.id"))
  print("   Successfully read test data.", quote = FALSE); print("", quote = FALSE)
  
  #preprocessing of the read data
  print("   Preprocessing test and train data...", quote = FALSE)
  print("   -- Extracting only the mean and standard deviation measurements...", quote = FALSE)
    temp <- getMeanAndStd(X_test, X_train)  #will return only those with mean and std computations from the training and testing data
    X_test <- temp[1]
    X_train <- temp[2]
  print("       DONE.", quote = FALSE)
  print("   -- Combining subject ids, features, and labels...", quote = FALSE)
  train <- cbind(subject_train, X_train, Y_train) #combines all the data (i.e., the subject_id, features, and activity labels)
  test <- cbind(subject_test, X_test, Y_test)     #same as previous line
  print("       DONE.", quote = FALSE)
  
  print("   Preprocessing done!", quote = FALSE); print("", quote = FALSE)
  
  #merging the data using rbind
  print("   Merging test and train data sets...", quote = FALSE)
  merged <- rbind(train, test)
  print("   MERGE COMPLETE.", quote = FALSE); print("", quote = FALSE)
  print("", quote = FALSE)
  
  merged

}#end of processData

#end of file