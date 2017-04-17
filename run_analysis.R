#Load relevant librarys
library(lubridate)
library(jpeg)
library(dplyr)
library(reshape2)

###### Get Started
# Unzip data and store
# Read and understand provided information on activity data set by Samsung wearables

###### 1. Merges the training and the test sets to create one data set
# Names: Column names for columns 1-561 of "x_..." are contained in features.txt
setwd('H:/Programming/Coursera_Lib/GettingAndCleaningData/Week4/peergraded/UCI HAR Dataset')
feature_names <- read.table('features.txt',header = FALSE)

# Read Train data in, append the labels & subject identifier, provide names of features.txt to each column
setwd('H:/Programming/Coursera_Lib/GettingAndCleaningData/Week4/peergraded/UCI HAR Dataset/train')
y_train <- read.table('y_train.txt', header = FALSE)
names(y_train)[1]<-"lables"
train_subject <- read.table('subject_train.txt', header = FALSE)
names(train_subject)[1]<-"subject"
x_train <- read.table('x_train.txt', header = FALSE)
# Merge train data
train_merge <- cbind(x_train, y_train, train_subject)

# Read Train data in, append the labels & subject identifier, provide names of features.txt to each column
setwd('H:/Programming/Coursera_Lib/GettingAndCleaningData/Week4/peergraded/UCI HAR Dataset/test')
y_test <- read.table('y_test.txt', header = FALSE)
names(y_test)[1]<-"lables"
test_subject <- read.table('subject_test.txt', header = FALSE)
names(test_subject)[1]<-"subject"
x_test <- read.table('x_test.txt', header = FALSE)
# Merge train data
test_merge <- cbind(x_test, y_test, test_subject)

## Merge test and train datasets
merge_all <- rbind(train_merge,test_merge)


###### 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Find the Integer Column numbers of the relevant data
std_mean <- grep("[Mm]ean|[Ss]td", feature_names$V2) #welche means und stds genau?
data <- select(merge_all, c(std_mean,562,563))

feature_names$V2[std_mean]
###### 3. Uses descriptive activity names to name the activities in the data set
# Read in activities
setwd('H:/Programming/Coursera_Lib/GettingAndCleaningData/Week4/peergraded/UCI HAR Dataset')
# Rename activities
activity_names <- read.table('activity_labels.txt',header = FALSE)
activity_names$V3 <- c("walk", "walk up", "walk down", "sit", "stand", "lay")

###### 4. Appropriately labels the data set with descriptive variable names.
rename_variables <- c("acceleration_x", "acceleration_y", "acceleration_z", 
                 "acceleration_x_std", "acceleration_y_std", "acceleration_z_std",
                 "gravity_x", "gravity_y", "gravity_z", 
                 "gravity_x_std", "gravity_y_std", "gravity_z_std",
                 "acceleration_jerk_x", "acceleration_jerk_y", "acceleration_jerk_z", 
                 "acceleration_jerk_x_std", "acceleration_jerk_y_std", "acceleration_jerk_z_std",
                 "gyroscope_x", "gyroscope_y", "gyroscope_z", 
                 "gyroscope_x_std", "gyroscope_y_std", "gyroscope_z_std",
                 "gyroscope_jerk_x", "gyroscope_jerk_y", "gyroscope_jerk_z", 
                 "gyroscope_jerk_x_std", "gyroscope_jerk_y_std", "gyroscope_jerk_z_std",
                 "acceleration_magnitude", "acceleration_magnitude_std",
                 "acceleration_magnitude_gravity", "acceleration_magnitude_gravity_std",
                 "acceleration_magnitude_gravity_jerk", "acceleration_magnitude_gravity_jerk_std",
                 "gyroscope_magnitude", "gyroscope_magnitude_std",
                 "gyroscope_magnitude_gravity_jerk", "gyroscope_magnitude_gravity_jerk_std",
                 "acceleration_freq_x", "acceleration_freq_y", "acceleration_freq_z", 
                 "acceleration_freq_x_std", "acceleration_freq_y_std", "acceleration_freq_z_std",
                 "acceleration_meanfreq_x", "acceleration_meanfreq_y", "acceleration_meanfreq_z", 
                 "acceleration_jerk_freq_x", "acceleration_jerk_freq_y", "acceleration_jerk_freq_z",
                 "acceleration_jerk_freq_x_std", "acceleration_jerk_freq_y_std", "acceleration_jerk_freq_z_std",
                 "acceleration_jerk_meanfreq_x", "acceleration_jerk_meanfreq_y", "acceleration_jerk_meanfreq_z",
                 "gyroscope_freq_x", "gyroscope_freq_y", "gyroscope_freq_z", 
                 "gyroscope_freq_x_std", "gyroscope_freq_y_std", "gyroscope_freq_z_std",
                 "gyroscope_meanfreq_x", "gyroscope_meanfreq_y", "gyroscope_meanfreq_z", 
                 "acceleration_magnitude_freq", "acceleration_magnitude_freq_std", "acceleration_magnitude_meanfreq",
                 "acceleration_jerk_magnitude_freq", "acceleration_jerk_magnitude_freq_std", "acceleration_jerk_magnitude_meanfreq",
                 "gyroscope_magnitude_freq", "gyroscope_magnitude_freq_std", "gyroscope_magnitude_meanfreq",
                 "gyroscope_jerk_magnitude_freq", "gyroscope_jerk_magnitude_freq_std", "gyroscope_jerk_magnitude_meanfreq",
                 "angle_acceleration_gravity", "angle_acceleration_jerk_gravity", "angle_gyroscope_gravity", 
                 "angle_gyroscope_jerk_gravity", 
                 "angle_x_gravity", "angle_y_gravity", "angle_z_gravity", 
                 "labels", "subject")
names(data) <- rename_variables

###### 5. From the data set in step 4, creates a second, independent tidy data set 
######    with the average of each variable for each activity and each subject.

k = 1

for (j in 1:6){ # Loop through all labels
  for (i in 1:30){ # loop through all subjects

test10 <- filter(data, data$labels == j)
test11 <- filter(test10, test10$subject == i)
result <- lapply(test11, mean)
  if (i == 1 && j == 1) {
  result_means <- data.frame(result) # store result in data.frame
  }
  else {
  result_means[k,] <- data.frame(result)
  }

k = k+1
  } 
}

###### Store result
# Labels and Subjects are indicated in the last 2 columns, named: "labels" and "subject".
setwd('H:/Programming/Coursera_Lib/GettingAndCleaningData/Week4/peergraded')
write.table(result_means, "result_means.txt", row.name=FALSE)
# End
