# DataScience_AssignmentWearables
Results for assignment on wearables data

Please check out the codebook for information on the data.
If you like to run the code on your computer, please make sure to insert the correct "setwd" path as your working directory pointing at your saved data.

What did i do with the data?

Get Started
# Load relevant librarys into R
# Unzip data and store
# Read and understand provided information on activity data set by Samsung wearables

###### Task 1. Merges the training and the test sets to create one data set
# Names: Column names for columns 1-561 of "x_..." are contained in features.txt

# Read Train data in, append the labels & subject identifier, provide names of features.txt to each column
# Merge train data

# Read Train data in, append the labels & subject identifier, provide names of features.txt to each column
# Merge train data

## Merge test and train datasets

###### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Find the Integer Column numbers of the relevant data

###### 3. Uses descriptive activity names to name the activities in the data set
# Read in activities
# Rename activities

###### 4. Appropriately labels the data set with descriptive variable names.

###### 5. From the data set in step 4, creates a second, independent tidy data set 
######    with the average of each variable for each activity and each subject.

# Store result
# The columns result$labels and result$subject indicate the values applied for each row. Each row hence contains the mean data for a specific combination of label and subject.
# End
