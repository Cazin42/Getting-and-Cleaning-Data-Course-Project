README
==

Getting and Cleaning Data Course Project
--

At first, you could read "CodeBook.md" which delivers a lot of useful information. 

Then you could open the file : "run_analysis.R" which :
- downloads the dataset if it does not already exist in the working directory
- loads the activity and feature info
- loads both the training and test datasets, keeping only those columns which reflect a mean or standard deviation
- loads the activity and subject data for each dataset, and merges those columns with the dataset
- merges the two datasets
- converts the activity and subject columns into factors
- creates a tidy dataset that consists of the average (mean) value of each variable for each subject and each activity.

The final result is the file "tidy.txt".

