---
title: "Codebook - Getting and Cleaning Data - Course Assignment"
author: "Adam Moses"
date: "November 22, 2015"
---

Data Description
----------------

The data used in this project was originally sourced from the Machine Learning Library of UCI. That source site can be found at the following url.

(https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

The data was downloaded from the url below.

(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

The data references the recordings of accelerometer and gryoscope data from a Samsung phone will being used by 30 different human subjects performing 6 different activites, i.e. running, walking, etc.

The data contains eight files of interest to this project. They are:

1. activity_labels.txt
2. features.txt
3. test/subject_test.txt
4. test/y_test.txt
5. test/X_test.txt
6. test/subject_test.txt
7. test/y_test.txt
8. test/X_test.txt

### Activities ###

This data set links the class labels with their activity name.

### Features ###

This data references all of the variables found in the training and test data sets, essentially naming the columns of the data.

### Test Data ###

This comprises 30% of all of the data. It contains three parts.

1. The subject index, for the subject each row of the data matches.
2. The activity (Y) index, for the activity each row of data matches.
3. The data itself (X), which has 561 variables per observation matching the variables presented in the features seciton.

### Training Data ###

This comprises 70% of all of the data. It contains three parts that match what was specified in the test data.

1. The subject index, for the subject each row of the data matches.
2. The activity (Y) index, for the activity each row of data matches.
3. The data itself (X), which has 561 variables per observation.

Transformation
--------------

In order to clean and tidy the data a few keep operations were used. These operatoins and they steps they are a part of are discussed in more detail in the readme and in the script itself.

* The variable/feature names are changed slightly but not extensively to be more readable, but they are alreayd fairly descriptive from a scientific perspective.
* Only variables relating to the mean of standard deviation are used, i.e. -mean() and -std(). The mean frequency is not used because it is not a mean of interest in this project.
* The final table tidy dataset is the computed column means of the interested variables for each combination of subject and activity.
* The "master" dataset that these column means are computed from consists only of the:
     * Variables of interest
     * The subjectID
     * The activity category and readable name
* The column means are produced by iterating through the sets of the unique subjects and activities and then producing a subset of just these matches from the master dataset.

Variables
---------

A sample of the computed dataset are shown below, generated from computedDataset[1:8,1:8].

                                                    SubjectID ActivityCategory       ActivityName tBodyAccMeanXAVG
     Averages of Subject 1 while Walking                    1                1            Walking        0.2773308
     Averages of Subject 1 while Walking Upstairs           1                2   Walking Upstairs        0.2554617
     Averages of Subject 1 while Walking Downstairs         1                3 Walking Downstairs        0.2891883
     Averages of Subject 1 while Sitting                    1                4            Sitting        0.2612376
     Averages of Subject 1 while Standing                   1                5           Standing        0.2789176
     Averages of Subject 1 while Laying                     1                6             Laying        0.2215982
     Averages of Subject 2 while Walking                    2                1            Walking        0.2764266
                                                    tBodyAccMeanYAVG tBodyAccMeanZAVG tGravityAccMeanXAVG
     Averages of Subject 1 while Walking                -0.017383819       -0.1111481           0.9352232
     Averages of Subject 1 while Walking Upstairs       -0.023953149       -0.0973020           0.8933511
     Averages of Subject 1 while Walking Downstairs     -0.009918505       -0.1075662           0.9318744
     Averages of Subject 1 while Sitting                -0.001308288       -0.1045442           0.8315099
     Averages of Subject 1 while Standing               -0.016137590       -0.1106018           0.9429520
     Averages of Subject 1 while Laying                 -0.040513953       -0.1132036          -0.2488818
     Averages of Subject 2 while Walking                -0.018594920       -0.1055004           0.9130173

The variables in the final dataset are and summarised as:

        SubjectID    ActivityCategory             ActivityName tBodyAccMeanXAVG tBodyAccMeanYAVG   
      Min.   : 1.0   Min.   :1.0      Laying            :30    Min.   :0.2216   Min.   :-0.040514  
      1st Qu.: 8.0   1st Qu.:2.0      Sitting           :30    1st Qu.:0.2712   1st Qu.:-0.020022  
      Median :15.5   Median :3.5      Standing          :30    Median :0.2770   Median :-0.017262  
      Mean   :15.5   Mean   :3.5      Walking           :30    Mean   :0.2743   Mean   :-0.017876  
      3rd Qu.:23.0   3rd Qu.:5.0      Walking Downstairs:30    3rd Qu.:0.2800   3rd Qu.:-0.014936  
      Max.   :30.0   Max.   :6.0      Walking Upstairs  :30    Max.   :0.3015   Max.   :-0.001308  
      tBodyAccMeanZAVG   tGravityAccMeanXAVG tGravityAccMeanYAVG tGravityAccMeanZAVG tBodyAccJerkMeanXAVG
      Min.   :-0.15251   Min.   :-0.6800     Min.   :-0.47989    Min.   :-0.49509    Min.   :0.04269     
      1st Qu.:-0.11207   1st Qu.: 0.8376     1st Qu.:-0.23319    1st Qu.:-0.11726    1st Qu.:0.07396     
      Median :-0.10819   Median : 0.9208     Median :-0.12782    Median : 0.02384    Median :0.07640     
      Mean   :-0.10916   Mean   : 0.6975     Mean   :-0.01621    Mean   : 0.07413    Mean   :0.07947     
      3rd Qu.:-0.10443   3rd Qu.: 0.9425     3rd Qu.: 0.08773    3rd Qu.: 0.14946    3rd Qu.:0.08330     
      Max.   :-0.07538   Max.   : 0.9745     Max.   : 0.95659    Max.   : 0.95787    Max.   :0.13019     
      tBodyAccJerkMeanYAVG tBodyAccJerkMeanZAVG tBodyGyroMeanXAVG  tBodyGyroMeanYAVG  tBodyGyroMeanZAVG 
      Min.   :-0.0386872   Min.   :-0.067458    Min.   :-0.20578   Min.   :-0.20421   Min.   :-0.07245  
      1st Qu.: 0.0004664   1st Qu.:-0.010601    1st Qu.:-0.04712   1st Qu.:-0.08955   1st Qu.: 0.07475  
      Median : 0.0094698   Median :-0.003861    Median :-0.02871   Median :-0.07318   Median : 0.08512  
      Mean   : 0.0075652   Mean   :-0.004953    Mean   :-0.03244   Mean   :-0.07426   Mean   : 0.08744  
      3rd Qu.: 0.0134008   3rd Qu.: 0.001958    3rd Qu.:-0.01676   3rd Qu.:-0.06113   3rd Qu.: 0.10177  
      Max.   : 0.0568186   Max.   : 0.038053    Max.   : 0.19270   Max.   : 0.02747   Max.   : 0.17910  
      tBodyGyroJerkMeanXAVG tBodyGyroJerkMeanYAVG tBodyGyroJerkMeanZAVG tBodyAccMagMeanAVG tGravityAccMagMeanAVG
      Min.   :-0.15721      Min.   :-0.07681      Min.   :-0.092500     Min.   :-0.9865    Min.   :-0.9865      
      1st Qu.:-0.10322      1st Qu.:-0.04552      1st Qu.:-0.061725     1st Qu.:-0.9573    1st Qu.:-0.9573      
      Median :-0.09868      Median :-0.04112      Median :-0.053430     Median :-0.4829    Median :-0.4829      
      Mean   :-0.09606      Mean   :-0.04269      Mean   :-0.054802     Mean   :-0.4973    Mean   :-0.4973      
      3rd Qu.:-0.09110      3rd Qu.:-0.03842      3rd Qu.:-0.048985     3rd Qu.:-0.0919    3rd Qu.:-0.0919      
      Max.   :-0.02209      Max.   :-0.01320      Max.   :-0.006941     Max.   : 0.6446    Max.   : 0.6446      
      tBodyAccJerkMagMeanAVG tBodyGyroMagMeanAVG tBodyGyroJerkMagMeanAVG fBodyAccMeanXAVG  fBodyAccMeanYAVG  
      Min.   :-0.9928        Min.   :-0.9807     Min.   :-0.99732        Min.   :-0.9952   Min.   :-0.98903  
      1st Qu.:-0.9807        1st Qu.:-0.9461     1st Qu.:-0.98515        1st Qu.:-0.9787   1st Qu.:-0.95361  
      Median :-0.8168        Median :-0.6551     Median :-0.86479        Median :-0.7691   Median :-0.59498  
      Mean   :-0.6079        Mean   :-0.5652     Mean   :-0.73637        Mean   :-0.5758   Mean   :-0.48873  
      3rd Qu.:-0.2456        3rd Qu.:-0.2159     3rd Qu.:-0.51186        3rd Qu.:-0.2174   3rd Qu.:-0.06341  
      Max.   : 0.4345        Max.   : 0.4180     Max.   : 0.08758        Max.   : 0.5370   Max.   : 0.52419  
      fBodyAccMeanZAVG  fBodyAccJerkMeanXAVG fBodyAccJerkMeanYAVG fBodyAccJerkMeanZAVG fBodyGyroMeanXAVG
      Min.   :-0.9895   Min.   :-0.9946      Min.   :-0.9894      Min.   :-0.9920      Min.   :-0.9931  
      1st Qu.:-0.9619   1st Qu.:-0.9828      1st Qu.:-0.9725      1st Qu.:-0.9796      1st Qu.:-0.9697  
      Median :-0.7236   Median :-0.8126      Median :-0.7817      Median :-0.8707      Median :-0.7300  
      Mean   :-0.6297   Mean   :-0.6139      Mean   :-0.5882      Mean   :-0.7144      Mean   :-0.6367  
      3rd Qu.:-0.3183   3rd Qu.:-0.2820      3rd Qu.:-0.1963      3rd Qu.:-0.4697      3rd Qu.:-0.3387  
      Max.   : 0.2807   Max.   : 0.4743      Max.   : 0.2767      Max.   : 0.1578      Max.   : 0.4750  
      fBodyGyroMeanYAVG fBodyGyroMeanZAVG fBodyAccMagMeanAVG fBodyBodyAccJerkMagMeanAVG fBodyBodyGyroMagMeanAVG
      Min.   :-0.9940   Min.   :-0.9860   Min.   :-0.9868    Min.   :-0.9940            Min.   :-0.9865        
      1st Qu.:-0.9700   1st Qu.:-0.9624   1st Qu.:-0.9560    1st Qu.:-0.9770            1st Qu.:-0.9616        
      Median :-0.8141   Median :-0.7909   Median :-0.6703    Median :-0.7940            Median :-0.7657        
      Mean   :-0.6767   Mean   :-0.6044   Mean   :-0.5365    Mean   :-0.5756            Mean   :-0.6671        
      3rd Qu.:-0.4458   3rd Qu.:-0.2635   3rd Qu.:-0.1622    3rd Qu.:-0.1872            3rd Qu.:-0.4087        
      Max.   : 0.3288   Max.   : 0.4924   Max.   : 0.5866    Max.   : 0.5384            Max.   : 0.2040        
      fBodyBodyGyroJerkMagMeanAVG tBodyAccStdDevXAVG tBodyAccStdDevYAVG tBodyAccStdDevZAVG tGravityAccStdDevXAVG
      Min.   :-0.9976             Min.   :-0.9961    Min.   :-0.99024   Min.   :-0.9877    Min.   :-0.9968      
      1st Qu.:-0.9813             1st Qu.:-0.9799    1st Qu.:-0.94205   1st Qu.:-0.9498    1st Qu.:-0.9825      
      Median :-0.8779             Median :-0.7526    Median :-0.50897   Median :-0.6518    Median :-0.9695      
      Mean   :-0.7564             Mean   :-0.5577    Mean   :-0.46046   Mean   :-0.5756    Mean   :-0.9638      
      3rd Qu.:-0.5831             3rd Qu.:-0.1984    3rd Qu.:-0.03077   3rd Qu.:-0.2306    3rd Qu.:-0.9509      
      Max.   : 0.1466             Max.   : 0.6269    Max.   : 0.61694   Max.   : 0.6090    Max.   :-0.8296      
      tGravityAccStdDevYAVG tGravityAccStdDevZAVG tBodyAccJerkStdDevXAVG tBodyAccJerkStdDevYAVG
      Min.   :-0.9942       Min.   :-0.9910       Min.   :-0.9946        Min.   :-0.9895       
      1st Qu.:-0.9711       1st Qu.:-0.9605       1st Qu.:-0.9832        1st Qu.:-0.9724       
      Median :-0.9590       Median :-0.9450       Median :-0.8104        Median :-0.7756       
      Mean   :-0.9524       Mean   :-0.9364       Mean   :-0.5949        Mean   :-0.5654       
      3rd Qu.:-0.9370       3rd Qu.:-0.9180       3rd Qu.:-0.2233        3rd Qu.:-0.1483       
      Max.   :-0.6436       Max.   :-0.6102       Max.   : 0.5443        Max.   : 0.3553       
      tBodyAccJerkStdDevZAVG tBodyGyroStdDevXAVG tBodyGyroStdDevYAVG tBodyGyroStdDevZAVG tBodyGyroJerkStdDevXAVG
      Min.   :-0.99329       Min.   :-0.9943     Min.   :-0.9942     Min.   :-0.9855     Min.   :-0.9965        
      1st Qu.:-0.98266       1st Qu.:-0.9735     1st Qu.:-0.9629     1st Qu.:-0.9609     1st Qu.:-0.9800        
      Median :-0.88366       Median :-0.7890     Median :-0.8017     Median :-0.8010     Median :-0.8396        
      Mean   :-0.73596       Mean   :-0.6916     Mean   :-0.6533     Mean   :-0.6164     Mean   :-0.7036        
      3rd Qu.:-0.51212       3rd Qu.:-0.4414     3rd Qu.:-0.4196     3rd Qu.:-0.3106     3rd Qu.:-0.4629        
      Max.   : 0.03102       Max.   : 0.2677     Max.   : 0.4765     Max.   : 0.5649     Max.   : 0.1791        
      tBodyGyroJerkStdDevYAVG tBodyGyroJerkStdDevZAVG tBodyAccMagStdDevAVG tGravityAccMagStdDevAVG
      Min.   :-0.9971         Min.   :-0.9954         Min.   :-0.9865      Min.   :-0.9865        
      1st Qu.:-0.9832         1st Qu.:-0.9848         1st Qu.:-0.9430      1st Qu.:-0.9430        
      Median :-0.8942         Median :-0.8610         Median :-0.6074      Median :-0.6074        
      Mean   :-0.7636         Mean   :-0.7096         Mean   :-0.5439      Mean   :-0.5439        
      3rd Qu.:-0.5861         3rd Qu.:-0.4741         3rd Qu.:-0.2090      3rd Qu.:-0.2090        
      Max.   : 0.2959         Max.   : 0.1932         Max.   : 0.4284      Max.   : 0.4284        
      tBodyAccJerkMagStdDevAVG tBodyGyroMagStdDevAVG tBodyGyroJerkMagStdDevAVG fBodyAccStdDevXAVG
      Min.   :-0.9946          Min.   :-0.9814       Min.   :-0.9977           Min.   :-0.9966   
      1st Qu.:-0.9765          1st Qu.:-0.9476       1st Qu.:-0.9805           1st Qu.:-0.9820   
      Median :-0.8014          Median :-0.7420       Median :-0.8809           Median :-0.7470   
      Mean   :-0.5842          Mean   :-0.6304       Mean   :-0.7550           Mean   :-0.5522   
      3rd Qu.:-0.2173          3rd Qu.:-0.3602       3rd Qu.:-0.5767           3rd Qu.:-0.1966   
      Max.   : 0.4506          Max.   : 0.3000       Max.   : 0.2502           Max.   : 0.6585   
      fBodyAccStdDevYAVG fBodyAccStdDevZAVG fBodyAccJerkStdDevXAVG fBodyAccJerkStdDevYAVG fBodyAccJerkStdDevZAVG
      Min.   :-0.99068   Min.   :-0.9872    Min.   :-0.9951        Min.   :-0.9905        Min.   :-0.993108     
      1st Qu.:-0.94042   1st Qu.:-0.9459    1st Qu.:-0.9847        1st Qu.:-0.9737        1st Qu.:-0.983747     
      Median :-0.51338   Median :-0.6441    Median :-0.8254        Median :-0.7852        Median :-0.895121     
      Mean   :-0.48148   Mean   :-0.5824    Mean   :-0.6121        Mean   :-0.5707        Mean   :-0.756489     
      3rd Qu.:-0.07913   3rd Qu.:-0.2655    3rd Qu.:-0.2475        3rd Qu.:-0.1685        3rd Qu.:-0.543787     
      Max.   : 0.56019   Max.   : 0.6871    Max.   : 0.4768        Max.   : 0.3498        Max.   :-0.006236     
      fBodyGyroStdDevXAVG fBodyGyroStdDevYAVG fBodyGyroStdDevZAVG fBodyAccMagStdDevAVG
      Min.   :-0.9947     Min.   :-0.9944     Min.   :-0.9867     Min.   :-0.9876     
      1st Qu.:-0.9750     1st Qu.:-0.9602     1st Qu.:-0.9643     1st Qu.:-0.9452     
      Median :-0.8086     Median :-0.7964     Median :-0.8224     Median :-0.6513     
      Mean   :-0.7110     Mean   :-0.6454     Mean   :-0.6577     Mean   :-0.6210     
      3rd Qu.:-0.4813     3rd Qu.:-0.4154     3rd Qu.:-0.3916     3rd Qu.:-0.3654     
      Max.   : 0.1966     Max.   : 0.6462     Max.   : 0.5225     Max.   : 0.1787     
      fBodyBodyAccJerkMagStdDevAVG fBodyBodyGyroMagStdDevAVG fBodyBodyGyroJerkMagStdDevAVG
      Min.   :-0.9944              Min.   :-0.9815           Min.   :-0.9976              
      1st Qu.:-0.9752              1st Qu.:-0.9488           1st Qu.:-0.9802              
      Median :-0.8126              Median :-0.7727           Median :-0.8941              
      Mean   :-0.5992              Mean   :-0.6723           Mean   :-0.7715              
      3rd Qu.:-0.2668              3rd Qu.:-0.4277           3rd Qu.:-0.6081              
      Max.   : 0.3163              Max.   : 0.2367           Max.   : 0.2878              

