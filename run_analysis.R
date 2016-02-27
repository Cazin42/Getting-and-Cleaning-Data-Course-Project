#' ---
#' title: "run_analysis"
#' author: "CAZIN Olivier"
#' date: "2016/02/25"
#' output: md_document
#' ---

#--------------------------------------------------
# Coursera : Collecting and Cleaning Data Project
#--------------------------------------------------

 # +++++++++++++++++++++++++++++++  
 # Objective 0 : Get and read data
 # +++++++++++++++++++++++++++++++

 # Set work directory
 setwd("C:/Users/Olivier/Desktop/Collecting and Cleaning Data - Project/")
   # Create data sub directory if it doen't exist
   if (!file.exists("./data"))
     {
      dir.create("./data")
     }
 # Download files from Website
 if (!file.exists("./data/UCI HAR Dataset"))
  {
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip")
  # Unzip directory (Décompression du dossier)
  unzip(zipfile="./data/Dataset.zip", exdir="./data")
  f_path <- file.path("./data/")
  files <- list.files(f_path,recursive=TRUE)
  # list all files
  files
  }

 # Redefine work directory after downloading files from Website
 setwd("C:/Users/Olivier/Desktop/Collecting and Cleaning Data - Project/data/")

 # read files
 # read the test and training set
 x.test <- read.table("./UCI HAR Dataset/test/X_test.txt")
 x.train <- read.table("./UCI HAR Dataset/train/X_train.txt")
 # read the test and training labels
 y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
 y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
 # read the test and training subjects 
 subject.test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
 subject.train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
 # read file which links the class labels with their activity name.
 activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt", colClasses="character")
 # read file which list all features
 features <- read.table("./UCI HAR Dataset/features.txt", colClasses="character")
 
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 # Objective 1 : Merge the training and the test sets to create one data set
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 # combine R objects by rows 
 x.all <- rbind(x.train, x.test)
 # rename columns
 colnames(x.all) <- features[,2]
 
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 # Objective 2 : Extract only the measurements on the mean and standard deviation for each measurement
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  
 meansd <- grep("(mean|std)\\(", colnames(x.all))
 x.meansd <- x.all[,c(meansd)]
 
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 # Objective 3 : Use descriptive activity names to name the activities in the data set
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 # combine R objects by rows 
 y.all <- rbind(y.train, y.test)
 colnames(y.all) <- c('activityId')
 # combine R objects by columns 
 all.meansd <- cbind(y.all, x.meansd)
 
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 # Objective 4 : Appropriately labels the data set with descriptive variable names
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 activityType <- c()
 for(i in 1:length(all.meansd[,1]))
   {
   activityType<-c(activityType,activity.labels[all.meansd[i,1],2])
 }
 # combine R objects by columns 
 all.meansd <- cbind(all.meansd, activityType)
 
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 # Objective 5 : From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
 # +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 # combine R objects by rows 
 subject.all <- rbind(subject.train, subject.test)
 colnames(subject.all) <- c('subjectId')
 # combine R objects by columns 
 all <- cbind(subject.all, all.meansd)
 
 # Calculate mean of each variable for each activity and each subject
 tidy_data <- aggregate(all[,3] ~ subjectId+activityType, data=all, FUN="mean")
 for(i in 4:(ncol(all)-1))
   {
   tidy_data[,i] <- aggregate( all[,i] ~ subjectId+activityType, data=all, FUN="mean")[,3]
   }
 colnames(tidy_data)[3:ncol(tidy_data)] <- colnames(x.meansd)
 
 # Rename correctly columns 
 names(tidy_data) <- gsub("std", "Std", names(tidy_data))
 names(tidy_data) <- gsub("mean", "Mean", names(tidy_data))
 names(tidy_data) <- gsub("\\(\\)", "", names(tidy_data))
 
 setwd("C:/Users/Olivier/Desktop/Collecting and Cleaning Data - Project/")
 
 # creaate the file : tidy_data.txt
 write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)
 
 