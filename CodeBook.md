GETTING AND CLEANING DATA COURSE PROJECT
====


Author : Olivier CAZIN  
Date : 2016/02/27  

This code book aims to describe the variables, the data, and any transformations or work performed to clean up the data

Data description
--

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The files used are listed below :
- The test and training set :
  - X_train.txt (7352 observations and 561 variables)
  - X_test.txt (2947 observations and 561 variables)
- The test and training labels :
  - y_train.txt (7352 observations and 1 variable)
  - y_test.txt (2947 observations and 1 variable)
- The test and training subjects 
  - subject_train.txt (7352 observations and 1 variable)
  - subject_test.txt (2947 observations and 1 variable)
- The file which links the class labels with their activity name
  - activity_labels.txt (6 observations and 2 variables)
- The file which list all features
  - features.txt (561 observations and 2 variables)

Read files : 

     x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
     x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
     y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
     y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
     subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
     subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
     activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses="character")
     features <- read.table("./UCI HAR Dataset/features.txt", colClasses="character")

Variables description
--

      str(x.train)
  
'data.frame':	7352 obs. of  561 variables:
 $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
 $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
 $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
 $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
 $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
 $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
 $ V7  : num  -0.995 -0.999 -0.997 -0.997 -0.998 ...
 $ V8  : num  -0.983 -0.975 -0.964 -0.983 -0.98 ...
 $ V9  : num  -0.924 -0.958 -0.977 -0.989 -0.99 ...
 $ V10 : num  -0.935 -0.943 -0.939 -0.939 -0.942 ...
 [list output truncated]

     str(x.test) 

'data.frame':	2947 obs. of  561 variables:
 $ V1  : num  0.257 0.286 0.275 0.27 0.275 ...
 $ V2  : num  -0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...
 $ V3  : num  -0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...
 $ V4  : num  -0.938 -0.975 -0.994 -0.995 -0.994 ...
 $ V5  : num  -0.92 -0.967 -0.97 -0.973 -0.967 ...
 $ V6  : num  -0.668 -0.945 -0.963 -0.967 -0.978 ...
 $ V7  : num  -0.953 -0.987 -0.994 -0.995 -0.994 ...
 $ V8  : num  -0.925 -0.968 -0.971 -0.974 -0.966 ...
 $ V9  : num  -0.674 -0.946 -0.963 -0.969 -0.977 ...
 $ V10 : num  -0.894 -0.894 -0.939 -0.939 -0.939 ...
 [list output truncated]

     str(y.train)

'data.frame':	7352 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

     str(y.test) 
 
 'data.frame':	2947 obs. of  1 variable:
 $ V1: int  5 5 5 5 5 5 5 5 5 5 ...

      str(subject.train) 
 
 'data.frame':	7352 obs. of  1 variable:
 $ V1: int  1 1 1 1 1 1 1 1 1 1 ...

      str(subject.test) 
 
 'data.frame':	2947 obs. of  1 variable:
 $ V1: int  2 2 2 2 2 2 2 2 2 2 ...

      str(activity.labels)
 
 'data.frame':	6 obs. of  2 variables:
 $ V1: chr  "1" "2" "3" "4" ...
 $ V2: chr  "WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" ...

      str(feature)

 'data.frame':	561 obs. of  2 variables:
 $ V1: chr  "1" "2" "3" "4" ...
 $ V2: chr  "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" "tBodyAcc-std()-X" ..
 
 
Transformations or work performed to clean up the data
--
 
Merge the training and the test sets to create one data set :

     x.all <- rbind(x.train, x.test)
     colnames(x.all) <- features[,2]
 
Extract only the measurements on the mean and standard deviation for each measurement :

     meansd <- grep("(mean|std)\\(", colnames(x.all))
     x.meansd <- x.all[,c(meansd)]

Use descriptive activity names to name the activities in the data set :

     y.all <- rbind(y.train, y.test)
     colnames(y.all) <- c('activityId')
     all.meansd <- cbind(y.all, x.meansd)

Appropriately labels the data set with descriptive variable names :

     activityType <- c()
     for(i in 1:length(all.meansd[,1]))
     {
     activityType<-c(activityType,activity.labels[all.meansd[i,1],2])
     }
     all.meansd <- cbind(all.meansd, activityType)

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject :

     subject.all <- rbind(subject.train, subject.test)
     colnames(subject.all) <- c('subjectId')
     all <- cbind(subject.all, all.meansd)
 
 Calculate mean of each variable for each activity and each subject :

     tidy_data <- aggregate(all[,3] ~ subjectId+activityType, data=all, FUN="mean")
     for(i in 4:(ncol(all)-1))
     {
     tidy_data[,i] <- aggregate( all[,i] ~ subjectId+activityType, data=all, FUN="mean")[,3]
     }
     colnames(tidy_data)[3:ncol(tidy_data)] <- colnames(x.meansd)
 
 Rename correctly columns :

     names(tidy_data) <- gsub("std", "Std", names(tidy_data))
      names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
     names(tidy_data) <- gsub("\\(\\)", "", names(tidy_data))
 
Create the file : tidy_data.txt :

      write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)









