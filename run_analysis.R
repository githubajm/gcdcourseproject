# ----------------------------------
# Adam Moses
# Getting And Cleaning Data - coursera
# 2015-11-22
# ----------------------------------
# Please see associated readme.MD and codebook.MD for further explanation
# on how everything works, code has also been commented to explain in detail
# all that is happening
# ----------------------------------

# ----------------------------------

loadTableFromFile <- function(tableName, fileName, useGlobalEnv)
{
     # if using global environment for table read-ins and storage
     if (useGlobalEnv)
     {
          # if table does not exist read it from file
          if (!exists(tableName, envir = .GlobalEnv))
          {
               message("Could not find table ", tableName, " in GlobalEnv, will read it from file", fileName)
               tableRead <- read.table(fileName)
               assign(tableName, tableRead, envir = .GlobalEnv)
               return(tableRead)
          }
          # if table does exist in global environment then use that one and skip read
          else
          {
               message("Found table ", tableName, " in GlobalEnv, will use GlobalEnv version and skip file read")
               return(get(tableName, envir = .GlobalEnv))
          }
     }
     else
     {
          # read table from file and return it
          message("Reading ", tableName, " from ", fileName)
          tableRead <- read.table(fileName)
          return(tableRead)
     }
}

# ----------------------------------

buildFilename <- function(datasetPath, theFilename)
{
     # return a string with the path and filename combined
     return(paste(datasetPath, "/", theFilename, sep = ""))
}

# ----------------------------------

buildFilenameList <- function(datasetPath)
{
     # create an empty list file the filenames
     filenameList <- list()
     
     # create the list of filenames
     filenameList$activityLabelsFilename   <- buildFilename(datasetPath, "activity_labels.txt")
     filenameList$featureNamesFilename     <- buildFilename(datasetPath, "features.txt")
     filenameList$testSubjectFilename      <- buildFilename(datasetPath, "test/subject_test.txt")
     filenameList$testActivityFilename     <- buildFilename(datasetPath, "test/y_test.txt")
     filenameList$testDataFilename         <- buildFilename(datasetPath, "test/X_test.txt")
     filenameList$trainSubjectFilename     <- buildFilename(datasetPath, "train/subject_train.txt")
     filenameList$trainActivityFilename    <- buildFilename(datasetPath, "train/y_train.txt")
     filenameList$trainDataFilename        <- buildFilename(datasetPath, "train/X_train.txt")

     # return the filename list
     return(filenameList)
}

# ----------------------------------

clearGobalEnv <- function()
{
     # clear all the named tables used from the global environment
     # note: this removes only the ones read in from the files
     message("Clearing variables read from files used by this program from the GlobalEnv")
     if (exists("activityLabels", envir = .GlobalEnv))
          remove("activityLabels", envir = .GlobalEnv)
     if (exists("featureNames", envir = .GlobalEnv))
          remove("featureNames", envir = .GlobalEnv)
     if (exists("testSubject", envir = .GlobalEnv))
          remove("testSubject", envir = .GlobalEnv)
     if (exists("testActivity", envir = .GlobalEnv))
          remove("testActivity", envir = .GlobalEnv)
     if (exists("testData", envir = .GlobalEnv))
          remove("testData", envir = .GlobalEnv)
     if (exists("trainSubject", envir = .GlobalEnv))
          remove("trainSubject", envir = .GlobalEnv)
     if (exists("trainActivity", envir = .GlobalEnv))
          remove("trainActivity", envir = .GlobalEnv)
     if (exists("trainData", envir = .GlobalEnv))
          remove("trainData", envir = .GlobalEnv)      
}

# ----------------------------------

checkToStoreObjectInGlobalEnv <- function(object, useGlobalEnv)
{
     # if flagged to store stuff in GlobalEnv then do so
     if (useGlobalEnv)
     {
          # get object as a name, message that it's being stored in GlobalEnv, store it
          objectName <- deparse(substitute(object))
          message("Writing object ", objectName, " to GlobalEnv, overwriting if it already exists")
          assign(deparse(substitute(object)), object, envir = .GlobalEnv)
     }    
}

# ----------------------------------

simpleCapitalize <- function(x) 
{
     # NOTE: this code is from the R documentation
     # will search for spaces to determine first letters of words and then capitalize them
     s <- strsplit(x, " ")[[1]]
     paste(toupper(substring(s, 1, 1)), substring(s, 2), sep="", collapse=" ")
}

# ----------------------------------

makePrettyActivityNames <- function(unprettyActivityNames)
{
     # get rid of underscores
     unprettyActivityNames <- sub("_", " ", unprettyActivityNames, fixed = TRUE)
     # make lower case
     unprettyActivityNames <- tolower(unprettyActivityNames)
     # capitalize the first letter of words to achieve capital case style
     unprettyActivityNames <- sapply(unprettyActivityNames, simpleCapitalize)
     # return the improved string vector
     return(unprettyActivityNames)
}

# ----------------------------------

makePrettyFeatureNames <- function(unprettyFeatureNames)
{
     # change mean to fit better
     unprettyFeatureNames <- sub("-mean()", "Mean", unprettyFeatureNames, fixed = TRUE)     
     # change mean to fit better
     unprettyFeatureNames <- sub("-std()", "StdDev", unprettyFeatureNames, fixed = TRUE)
     # get rid of any leftover dashes
     unprettyFeatureNames <- sub("-", "", unprettyFeatureNames, fixed = TRUE)
     # return the improved string vector
     return(unprettyFeatureNames)
}

# ----------------------------------

convertActivityCategoryToActivityName <- function(activityCategory, activityLabels)
{
     # gets the matching activity name from the data frame of categories and names
     return(activityLabels[activityLabels$ActivityCategory==activityCategory,"ActivityName"])
}

# ----------------------------------

columnAveragesForSubjectAndActivity <- function(subjectID, activityCategory, masterDataset)
{
     # gets the subset of rows matching the subject and category and returns the column averages of that
     return(colMeans
            (masterDataset[
                 masterDataset$SubjectID == subjectID & 
                      masterDataset$ActivityCategory == activityCategory,
                 4:dim(masterDataset)[2]]))
}

# ----------------------------------

run_analysis_main <- function(datasetPath = ".",
                     computedDatasetFilename = NULL,
                     useGlobalEnv = FALSE, 
                     clearGlobalEnvFirst = FALSE)
{
     # output the state of the input parameters
     message("datasetPath is set to ", datasetPath)
     if (is.null(computedDatasetFilename))
          message("computedDatasetFilename is unset, won't write to file")
     else
          message("computedDatasetFilename is set to ", computedDatasetFilename)
     message("useGlobalEnv is set to ", useGlobalEnv)
     message("clearGlobalEnvFirst is set to ", clearGlobalEnvFirst)
     
     # clear the global environment of the variables first if the flag is set
     if (clearGlobalEnvFirst)
          clearGobalEnv()
     
     # build and get the list of filenames
     filenameList <- buildFilenameList(datasetPath)
     
     # load the activity labels and feature names
     activityLabels <- loadTableFromFile("activityLabels", filenameList$activityLabelsFilename, useGlobalEnv)
     featureNames   <- loadTableFromFile("featureNames", filenameList$featureNamesFilename, useGlobalEnv)
     
     # rename the columns of the two data frames to something more useful
     names(activityLabels) <- c("ActivityCategory", "ActivityName")
     names(featureNames) <- c("FeatureIndex", "FeatureName")
     
     # load the test data
     testSubject  <- loadTableFromFile("testSubject", filenameList$testSubjectFilename, useGlobalEnv)
     testActivity <- loadTableFromFile("testActivity", filenameList$testActivityFilename, useGlobalEnv)
     testData     <- loadTableFromFile("testData", filenameList$testDataFilename, useGlobalEnv)
     
     # load the training data
     trainSubject  <- loadTableFromFile("trainSubject", filenameList$trainSubjectFilename, useGlobalEnv)
     trainActivity <- loadTableFromFile("trainActivity", filenameList$trainActivityFilename, useGlobalEnv)
     trainData     <- loadTableFromFile("trainData", filenameList$trainDataFilename, useGlobalEnv)     
     
     # get the features of interest in this project, mean and std
     meanVarIndicies <- grep("mean()", featureNames$FeatureName, fixed = TRUE)
     meanVarValues   <- grep("mean()", featureNames$FeatureName, fixed = TRUE, value = TRUE)
     stdVarIndicies  <- grep("std()", featureNames$FeatureName, fixed = TRUE)
     stdVarValues    <- grep("std()", featureNames$FeatureName, fixed = TRUE, value = TRUE)
     
     # combine the results for one set of the indicies and values
     varsToUseIndicies <- c(meanVarIndicies, stdVarIndicies)
     varsToUseValues   <- c(meanVarValues, stdVarValues)

     # make the feature names better looking
     varsToUseValues <- makePrettyFeatureNames(varsToUseValues)     

     # make the activity names better looking
     activityLabels$ActivityName <- makePrettyActivityNames(activityLabels$ActivityName)          
          
     # create the working datasets
     workingActivity <- rbind(trainActivity, testActivity)
     workingSubject <- rbind(trainSubject, testSubject)
     workingData <- rbind(trainData, testData)
     
     # get only the interested columns from the working dataset
     workingData <- workingData[, varsToUseIndicies]
     
     # rename the columns of each of the datasets
     names(workingActivity)  <- c("ActivityCategory")
     names(workingSubject)   <- c("SubjectID")
     names(workingData)      <- varsToUseValues

     # build a vector of the activity names by their category and name that column
     workingActivityNames <- sapply(workingActivity$ActivityCategory, 
                                    convertActivityCategoryToActivityName, 
                                    activityLabels)
     workingActivityNames <- data.frame(ActivityName = workingActivityNames)
     
     # merge the subject and both activity columns to the data
     masterDataset <- cbind(workingActivityNames, workingData)
     masterDataset <- cbind(workingActivity, masterDataset)
     masterDataset <- cbind(workingSubject, masterDataset)
     
     # sort the master dataset by subject and activity
     masterDataset <- masterDataset[order(masterDataset$SubjectID, masterDataset$ActivityCategory),]
     
     # get the set of unique subjects and activities
     uniqueSubjects   <- unique(masterDataset$SubjectID)
     uniqueActivities <- unique(masterDataset$ActivityCategory)
     
     # setup a new computed dataset
     computedDataset <- masterDataset[0,4:dim(masterDataset)[2]]
     
     # create indexing columns to track the subject and activity
     subjectIDColumn          <- c()
     activityCategoryColumn   <- c()
     activityNameColumn       <- c()
     rowIndexNames            <- c()
     
     # iterate through the subjects
     for (currentSubject in uniqueSubjects)
     {
          # iterate through the activities
          for (currentActivity in uniqueActivities)
          {
               # append the subject and activity to the appropriate indexing columns
               subjectIDColumn        <- c(subjectIDColumn, currentSubject)
               activityCategoryColumn <- c(activityCategoryColumn, currentActivity)
               activityName           <- convertActivityCategoryToActivityName(currentActivity,
                                                                     activityLabels)
               activityNameColumn     <- c(activityNameColumn, activityName)
               rowIndexNames          <- c(rowIndexNames, 
                                           paste("Averages of Subject", 
                                                 currentSubject, 
                                                 "while", 
                                                 activityName))
               
               # compute the averages of the columns for the current subject and activity
               computedColumns <- columnAveragesForSubjectAndActivity(currentSubject,
                                                                       currentActivity,
                                                                      masterDataset)
               
               # add the computed averages as a row to the computed dataset
               computedDataset[dim(computedDataset)[1] + 1, ] <- computedColumns
          }
     }
     
     # add the front index columns for subject and activity
     computedDataset <- cbind(subjectIDColumn, 
                              activityCategoryColumn,
                              activityNameColumn,
                              computedDataset)
     
     # rename the index columns
     names(computedDataset)      <- paste(names(computedDataset), "AVG", sep = "")
     names(computedDataset)[1:3] <- c("SubjectID", "ActivityCategory", "ActivityName")
     
     # rename the row index
     row.names(computedDataset)  <- rowIndexNames
     
     # store working dataset in GlobalEnv if flagged to
     checkToStoreObjectInGlobalEnv(filenameList, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(activityLabels, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(featureNames, useGlobalEnv)     
     checkToStoreObjectInGlobalEnv(varsToUseIndicies, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(varsToUseValues, useGlobalEnv)     
     checkToStoreObjectInGlobalEnv(workingActivity, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(workingActivityNames, useGlobalEnv)     
     checkToStoreObjectInGlobalEnv(workingSubject, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(workingData, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(masterDataset, useGlobalEnv)
     checkToStoreObjectInGlobalEnv(computedDataset, useGlobalEnv)

     # if a computed dataset filename was passed in as a parameter then write to that file
     if (!is.null(computedDatasetFilename))
     {
          message("Writing computedDataset to file ", computedDatasetFilename)
          write.table(computedDataset, file = computedDatasetFilename, row.names = FALSE, col.names = TRUE)
     }

     # return the computed averages dataset
     return(computedDataset)
}

# ----------------------------------

run_analysis <- function()
{
     # run the main function of the script with the default parameters
     run_analysis_main()
}

# ----------------------------------

message("To run the script with the default parameters simply use 'run_analysis()'")
message("which will return the computed tidy dataset.")
message("You can also choose to run 'run_analysis_main()' which has the following")
message("parameters:")
message("  datasetPath = \".\" [determines the root path of the dataset]")
message("  computedDatasetFilename = NULL [if set will write the computed tidy")
message("                                  data to the filename]")
message("  useGlobalEnv = FALSE [will load table data from global environment")
message("                        if it exists]")
message("  clearGlobalEnvFirst = FALSE [will clear from the global environment")
message("                               the table data if they exist]")

# ----------------------------------
# Adam Moses
# Getting And Cleaning Data - coursera
# 2015-11-22
# ----------------------------------