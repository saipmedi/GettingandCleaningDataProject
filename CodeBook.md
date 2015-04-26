#CodeBook
#Introduction:
This codebook will explain the variables located in the UCI HAR dataset.


#The set of variables that were estimated from galaxy s phone signals are:
mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values.
iqr(): Interquartile range
entropy(): Signal entropy
arCoeff(): Autoregression coefficients with Burg order equal to 4
correlation(): Correlation coefficient between two signals
maxInds(): Index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): Skewness of the frequency domain signal
kurtosis(): Kurtosis of the frequency domain signal
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between some vectors.
No unit of measures is reported as all features were normalized and bounded within [-1,1].


#Data transformation:
Raw data sets were processed by run_analysis.R script to create a tidy data set subsetted by action and subject. The data folder was renamed to remove spaces.

#Merge training and test sets:

Test and training data (X_train.txt, X_test.txt), subject ids (subject_train.txt, subject_test.txt) and activity ids (y_train.txt, y_test.txt) were merged to obtain one master data set. Variables are labelled using features.txt located in the dataset directory.

#Extract mean and standard deviation variables:

variables with labels containing "mean" "std" were filtered.

#Use 'descriptive' activity names:
A new column was appended using Activity id column found in activity_labels.txt. 

#Label variables:
Variable names from the original datasource were simplified.

#Create tidy data:
A final tidy data set was created to have numeric variables and averaged for each activity/subject.

#The tidy data set contains 81 variables divided in:
Activity: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Subject: 1, 3, 5, 6, 7, 8, 11, 14, 15, 16, 17, 19, 21, 22, 23, 25, 26, 27, 28, 29, 30


#The data set is finally written to the file sensor_mean_activity_subject.txt.