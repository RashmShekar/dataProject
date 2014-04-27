setwd("G:/DataScience/Coursera/CleanData/")

setwd("G:/DataScience/Coursera/UCIHARDataset/test/")
x_test <- read.table("X_train.txt")
setwd("G:/DataScience/Coursera/UCIHARDataset/train/")
x_train <- read.table("X_train.txt", colClasses=columnClasses)

library(plyr)
mergeList <- list(body_acc_x_test, body_acc_y_test, body_acc_z_test, body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, total_acc_x_test, total_acc_y_test, total_acc_z_test, body_acc_x_train, body_acc_y_train, body_acc_z_train, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, total_acc_x_train, total_acc_y_train, total_acc_z_train)
setwd("G:/DataScience/Coursera/UCIHARDataset/")
features <- read.table("features.txt")

selectedFeatures <- c(grep("mean()",features$V2), grep("std()", features$V2))
columnsNotSelected <-  (1:nrow(features))[ -selectedFeatures]
columnClasses <- character(nrow(features))
columnClasses[columnsNotSelected] <- "NULL"
columnClasses[selectedFeatures] <- "numeric"

subject_train <- read.table("subject_train.txt")
activity_train <- read.table("y_train.txt")
new_train <- cbind(x_train, subject_train, activity_train)

setwd("G:/DataScience/Coursera/UCIHARDataset/test/")
subject_test <- read.table("subject_test.txt")
activity_test <- read.table("y_test.txt")
x_test <- read.table("X_test.txt", colClasses=columnClasses)
new_test <- cbind(x_test, subject_test, activity_test)

y_new <- rbind(new_train, new_test)
colnames(y_new) <- features[selectedFeatures, 2]
colnames(y_new[80])<- "Subject"
colnames(y_new[81])<- "Activity"

setwd("G:/DataScience/Coursera/UCIHARDataset/")
activityLabels <- read.table("activity_labels.txt")
y_new[81][y_new[81] == 1] <- "WALKING"
y_new[81][y_new[81] == 2] <- "WALKING_UPSTAIRS"
y_new[81][y_new[81] == 3] <- "WALKING_DOWNSTAIRS"
y_new[81][y_new[81] == 4] <- "SITTING"
y_new[81][y_new[81] == 5] <- "STANDING"
y_new[81][y_new[81] == 6] <- "LAYING"

splitTbl <- split(y_new, list(y_new[80], y_new[81]))

write.table(y_new, "G:/DataScience/Coursera/UCIHARDataset/tidyData.txt")