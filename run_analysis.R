library(plyr)

#Shortcuts to directories. I renamed UCI HAR directory to have no spaces...
uci_dir <-"UCI_HAR_Dataset/"
feature_file <- paste(uci_dir, "/features.txt", sep = "")
activity_labels_file <- paste(uci_dir, "/activity_labels.txt", sep = "")
x_train_file <- paste(uci_dir, "/train/X_train.txt", sep = "")
y_train_file <- paste(uci_dir, "/train/y_train.txt", sep = "")
subject_train_file <- paste(uci_dir, "/train/subject_train.txt", sep = "")
x_test_file  <- paste(uci_dir, "/test/X_test.txt", sep = "")
y_test_file  <- paste(uci_dir, "/test/y_test.txt", sep = "")
subject_test_file <- paste(uci_dir, "/test/subject_test.txt", sep = "")

#Load the filthy uncleaned data
features <- read.table(feature_file, colClasses = c("character"))
activity_labels <- read.table(activity_labels_file, col.names = c("ActivityId", "Activity"))
x_train <- read.table(x_train_file)
y_train <- read.table(y_train_file)
subject_train <- read.table(subject_train_file)
x_test <- read.table(x_test_file)
y_test <- read.table(y_test_file)
subject_test <- read.table(subject_test_file)

#Merge the two data sets into one master data set
training_sensor_data <- cbind(cbind(x_train, subject_train), y_train)
test_sensor_data <- cbind(cbind(x_test, subject_test), y_test)
sensor_data <- rbind(training_sensor_data, test_sensor_data)

#Label the columns
sensor_labels <- rbind(rbind(features, c(562, "Subject")), c(563, "ActivityId"))[,2]
names(sensor_data) <- sensor_labels

#Filter columbs by mean and standard deviations
sensor_data_mean_sd <- sensor_data[,grepl("mean|std|Subject|ActivityId", names(sensor_data))]

#Apply names given in "activity_labels.txt" to merged data
sensor_data_mean_sd <- join(sensor_data_mean_sd, activity_labels, by = "ActivityId", match = "first")
sensor_data_mean_sd <- sensor_data_mean_sd[,-1]
names(sensor_data_mean_sd) <- gsub('\\(|\\)',"",names(sensor_data_mean_sd), perl = TRUE)
names(sensor_data_mean_sd) <- make.names(names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('Acc',"Acceleration",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('GyroJerk',"AngularAcceleration",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('Gyro',"AngularSpeed",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('Mag',"Magnitude",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('^t',"TimeDomain.",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('^f',"FrequencyDomain.",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('\\.mean',".Mean",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('\\.std',".StandardDeviation",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('Freq\\.',"Frequency.",names(sensor_data_mean_sd))
names(sensor_data_mean_sd) <- gsub('Freq$',"Frequency",names(sensor_data_mean_sd))

#Create the independent tidy dataset
sensor_mean_activity_subject = ddply(sensor_data_mean_sd, c("Subject","Activity"), numcolwise(mean))
write.table(sensor_mean_activity_subject, file = "sensor_mean_activity_subject.txt",row.name=FALSE)