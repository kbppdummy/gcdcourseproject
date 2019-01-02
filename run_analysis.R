#
#   run_analysis.R
#   Code Description:
#       This is the main file that must be called.
#       Created for a Coursera Course Project.


run_analysis <- function(){
  #loads the libraries needed by the script, just in case it is not yet loaded
  #also loads the user-defined scripts: functions.R and merge.R
  print("****************************************", quote = FALSE)
  print("Loading necessary libraries and files...", quote = FALSE)
    library(dplyr)
    library(tidyr)
    source("./functions.R")
    source("./merge.R")
  print("DONE.", quote = FALSE)
  print("****************************************", quote = FALSE)
  
  #starts the analysis process
  print("Starting analysis...", quote = FALSE); print("", quote = FALSE)
    merged <- processData()                                 #this returns a data frame containing a merged test and train data set
    names(merged) <- makeAppropriateNames(names(merged))    #puts more readable variables names to the data frame
    merged <- changeActivityNames(merged)                   #converts the activity labels (i.e., 1-6) into readable form (e.g. 'walking')
  
  #once done, the merged data set will be saved in a file
  print("Saving the merged and cleaned data into merged.txt ...", quote = FALSE)
    write.table(merged, "merged.txt", row.names = FALSE)
  print("DONE.", quote = FALSE)
  print("****************************************", quote = FALSE)
  
  #this creates the second data set
  print("Creating the second data set...", quote = FALSE)
    newData <- createSecondDataSet(merged)
  print("DONE.", quote = FALSE)
  
  #and then also saves it to another .txt file
  print("Saving second data set into summaries.txt...", quote = FALSE)
    write.table(newData, "summaries.txt", row.names = FALSE)
  print("DONE.", quote = FALSE)
  print("****************************************", quote = FALSE)

}#end of run_analysis function

#end of file