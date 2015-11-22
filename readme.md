---
title: "Readme - Getting and Cleaning Data - Course Assignment"
author: "Adam Moses"
date: "November 22, 2015"
---

Summary
-------

This is the readme markdown document will describe how I handled the data and wrote my scripts to process the Samsung data as part of the course assignment for the Getting and Cleaning Data course part of coursera.org.

This document is broken down into 3 sections:

1. The Project Contents - Describes this document and the other related files
2. Data - Quick explanation of the data
3. Choices - Explaning some basic assumptions and choices I made doing this project
4. Code - A short step-by-step description of the code flow
5. How to Run - A quick description of how to call and run the code

The Project Contents
--------------------

The project is stored on GitHub at the address:

(https://github.com/githubajm/gcdcourseproject)

The files included are:

* readme.md - This file, which describes the contents and how the problem was solved
* run_analysis.R - The script file that tidys the data. This file can be loaded into R using the source("run_analysis.R") command. The function itself can be run by calling run_analysis(), or optionally with a set of custom parameters described further when the source is loaded.
* codebook.md - The code book for this project which describes in more detail the data involved.

Data
----

The data for this project is described in more detail in the file codebook.md which is part of this project.

To summarize breifly, the data is a collection of data points for human subjects who were using a Samsung Galazy smartphone which tracked both the activity the person was doing, i.e. walking, running, etc., and then a number of variables associated with the acceleromter on the phone.

The data was downloaded from the URL below.

(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

Please see the codebook.md for more.

Choices
-------

A couple of assumptions and choices made in this project:

* The data was download from the URL that was mentioned above, and then zipped into the working directory for this project so that the paths to the sub-directories are also from that working directory. For example the feature data is assumed to be at "./activity_labels.txt" and the training X data is assumed to be at "./train/X_train.txt".
* The data in the "Inertial Signals" folders are ignored as they have nothing to do with the project as it is described on the course page.
* Only the variabes with either -mean() or -std() are used. Ther is a variable called -meanFreq() but this is ignored as it is not strictly a mean variable.
* For all the observations the subjectID, the activity category (a number), and the activity name (a string), are included to fully qualifiy the observation.  For the original dataset this means there are more several observations like this for each combination of subject and activty, and for the final computed tidy dataset there is just one observation for each combination since they have collapsed these in order to produce the dataset.
* Not much was done to clean up the variable names as they were sufficiently clear even if full names were not used. However, they were standardized by case and the mean and std-dev were more explicity made clear in the names, and the () were removed for simplicty.

Code
----

Here is how the code works, described in brief. Please see the code itself as it is well commented and describes it more explicity.

1. Load the input data, there are 8 files in total. There are the activity labels and the features, then there are the two datasets, the training and test sets, which consist of the subjects, the activities, and the readings.
2. Rename the activty labels table to say Category and Names for recognizing and pairing the types.
3. Rename the feature table to say the Index and Feature Name.
4. Search through the variable feature names and find all the have either a "mean()" or "std()" in it. Keep a vector of those indices and the names
5. Clean-up the variable names, capitalize normally and remove the ()'s.
6. Combine the training and test datasets.
7. Keep only the variables of interest from this combined dataset.
8. Rename all of the columns with the tidier versions of them.
9. Using a column-bind, combine the subject and activty columns with the variable columns from the large dataset.
10. Iterate through the uniqiue sets of the subjects and the activities. For each pair of these values grab all matching observations and then perform a column average for all the columns found and store this as a row in a table.
11. Column-bind again the subject and activity to these computed column means.
12. Return this computed tidy data set.

As well there are a few optional things that this code tries to do:

* The tidy dataset can be written to a file using the write.table() command with row.names = FALSE.
* If flagged to do so, the data can be read from object in the global environment matching the expected object names.
* Also all the objects built during execution can be written to the global environment to be examined after.
* If flagged the code will clear the global environment of the objects used to the load the tables if they exist.

How To Run
----------

Below is the message that will be shown when the source for run_analysis.R is loaded. This describes the basic call as well as a parameterized version with explanations.

     To run the script with the default parameters simply use 'run_analysis()'
     which will return the computed tidy dataset.
     You can also choose to run 'run_analysis_main()' which has the following
     parameters:
       datasetPath = "." [determines the root path of the dataset]
       computedDatasetFilename = NULL [if set will write the computed tidy
                                       data to the filename]
       useGlobalEnv = FALSE [will load table data from global environment
                             if it exists]
       clearGlobalEnvFirst = FALSE [will clear from the global environment
                                    the table data if they exist]




Getting and Cleaning Data - Course Assignment

Adam Moses

November 22, 2015

