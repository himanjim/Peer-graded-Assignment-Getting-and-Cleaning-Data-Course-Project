# Check if package exist
if("reshape2" %in% rownames(installed.packages()) == FALSE) {
  install.packages("reshape2")
}

# Load the package
library(reshape2)

f_name <- "dataset.zip"

# Download the data
if (!file.exists(f_name)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, f_name)
}  
if (!file.exists("UCI HAR Dataset")) { 
# Unzip the data
  unzip(f_name) 
}

# Load activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels[,2] <- as.character(activity_labels[,2])
# Load features
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Get mean and standard deviation data
features_required <- grep(".*(mean|std).*", features[,2])
features_required.names <- features[features_required,2]
# Make data more clean
features_required.names = gsub('-mean', 'Mean', features_required.names)
features_required.names = gsub('-std', 'Std', features_required.names)
# Remove unncessary braces
features_required.names <- gsub('[-()]', '', features_required.names)


# Load the train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")[features_required]
train_activities <- read.table("UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
# Column bind the train datasets
train <- cbind(train_subjects, train_activities, train)

# Load the test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[features_required]
test_activities <- read.table("UCI HAR Dataset/test/Y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
# Column bind the test datasets
test <- cbind(test_subjects, test_activities, test)

# merge(row bind) train and test data
train_test_data <- rbind(train, test)
# add labels
colnames(train_test_data) <- c("subject", "activity", features_required.names)

# Factorise activities & subjects
train_test_data$activity <- factor(train_test_data$activity, levels = activity_labels[,1], labels = activity_labels[,2])
train_test_data$subject <- as.factor(train_test_data$subject)

# First melt the data then calculate mean
train_test_data.melted <- melt(train_test_data, id = c("subject", "activity"))
train_test_data.mean <- dcast(train_test_data.melted, subject + activity ~ variable, mean)

# Now write the tidy data
write.table(train_test_data.mean, "tidy.txt", row.names = FALSE, quote = FALSE)