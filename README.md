Run_Analysis_TidyData
=====================

This repository is used for the Week 3 project in the course "Getting and Cleaning Data" (www.coursera.com)

How the script works 
=====================
In RStudio, type 
> source("run_analysis.R")
>run_analysis()

And the default output is tidy_data_set.txt 

Variable Code Book
=====================
test_data_x (dimension: 2947*561): features for the test set
test_data_y (dimension: 2947*1): activities for the test set
test_subject (dimension: 2947*1): the subject IDs for the test set
test_data (dimension: 2947*563): horizontally combine the above three variables

train_data_x (dimension: 7352*561): features for the train set
train_data_y (dimension: 7352*1): activities for the train set
train_subject (dimension: 7352*1): the subject IDs for the train set
train_data (dimension: 7352*563): horizontally combine the above three variables

data_set (dimension: 10299*563): combined test data and train data vertically, as required by Step 1, including activities (col 1) and subject id(col 2)


measurement (dimension: 2*561): mean and standard deviation for each feature, as required by Step 2.
activities (dimension: 1*6): descriptive activities
feature_info (dimension:562*2): the second column gives the descriptive information for each feature

tidy_data_set (dimension: 180*563): the mean of all 561 variables for each activity (column 1) and for each subject (column 2)
filename: the file name that stores tidy_data_set
