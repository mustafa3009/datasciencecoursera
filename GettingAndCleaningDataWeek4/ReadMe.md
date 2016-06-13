# Coursera - Getting and Cleaning Data - Week 4 - Assignment

This is the assignment for the Getting and Cleaning Data week 4 of the course.
The R script `run_analysis.R` performs the following steps:

1. Load the library reshape2 as it will be required by the melt function.
2. Set the appropriate wordking dir
3. Download the dataset in a working directory (if not already exists)
4. Unzip the dataset
5. Identify the desired features / activities and store them in vectors
6. Load the training and test datasets, including only those columns (from desired features) which
   measure a mean or standard deviation
7. Merge the subject and activities with the training and test datasets using cbind function
8. Convert the `activity` and `subject` columns into factors
9. Calculate the mean by applying the melt and dcast functions
10.Create a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair.
11. Store the result in file `tidy.txt`.