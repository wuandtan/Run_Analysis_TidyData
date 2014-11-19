run_analysis <- function(fn = "tidy_data_set.txt")

#read test data x, y and subject_id and rename the y_test to "activity", rename the subject to subject_id
test_data_x <- read.table("X_test.txt");
test_data_y <- read.table("y_test.txt");
names(test_data_y) <- make.names("activity")
test_subject <- read.table("subject_test.txt");
names(test_subject) <- make.names("subject_id")
#combine test_data_y, test_subject and test_data_x into test_data, and remove the original ones
test_data <- cbind(test_data_y,test_subject,test_data_x)
rm("test_data_y","test_data_x","test_subject")

#read train data x, y and subject_id and rename the y_train to "activity", rename the subject to subject_id
train_data_x <- read.table("X_train.txt");
train_data_y <- read.table("y_train.txt");
names(train_data_y) <- make.names("activity")
train_subject <- read.table("subject_train.txt");
names(train_subject) <- make.names("subject_id")
#combine train_data_y, train_subject and train_data_x into train_data, and remove the original ones
train_data <- cbind(train_data_y,train_subject,train_data_x)
rm("train_data_y","train_data_x","train_subject")


#Step 1: Merges the training and the test sets to create one data set.
data_set <- rbind(train_data,test_data)
rm("train_data","test_data")

#Step 2: Extracts only the measurements on the mean and standard deviation for each measurement. 
measurement <- rbind(sapply(data_set[,3:ncol(data_set)],mean), sapply(data_set[,3:ncol(data_set)],sd))

#Step 3: Uses descriptive activity names to name the activities in the data set

activities <- c("WALKING","WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING");
#rename the first column "activity" from 1, 2, 3, 4, 5,6 to the activities variable
for (i in 1:length(activities))
{
  data_set$activity[data_set$activity==i] <- activities[i]
}

#Step 4: Appropriately labels the data set with descriptive variable names. 
feature_info <- read.table("project//getdata-projectfiles-UCI HAR Dataset//UCI HAR Dataset//features.txt")
#We found there are some duplicated variable names. So we rename the duplicated ones. For example, for the variable
# names 303, 317 and 331, they all have the name "fBodyAcc-bandsEnergy()-1,8". To discriminate them, we append .1, .2
# and .3 in the end of this name
feature_info[,2] <- as.character(feature_info[,2])
unique_info <- unique(feature_info[,2])
for (i in 1:length(unique_info))
{
  idx <- which(feature_info[,2]==unique_info[i])
  if(length(idx)>1)
  {
    for (j in 1:length(idx))
    {
      feature_info[idx[j],2] <- paste(feature_info[idx[j],2],".",j,sep="")
    }
  }
}
#assign the variable names to the corresponding columns in the data_set
colnames(data_set)[3:ncol(data_set)] <- feature_info[,2]

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy_data_set <- aggregate(. ~ activity + subject_id, data = data_set, mean)
#save to the file
write.table(tidy_data_set,file=fn, row.name=FALSE)