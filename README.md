# Getting-and-Cleaning-Data_Assignment

This repository has been created as part of assignment related to the course "Getting and Cleaning Data"

The data for this assignment is given here - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Following are the steps to be followed before executing the code. 

1. Download and unzip the data file into your R working directory
2. Eownload the R source code into your R working directory
3. Execute R source code to generate tidy data file

Data description

The variables in the data X are sensor signals. The variable in the data Y indicates activity type. In addition to this, there are necessary data for Subject and activity description.

Code explaination
The code combined training dataset and test dataset and extracted partial variables to create another dataset with the averages of each variable for each activity. The code has been written as per the specification in the assignment.

New dataset
The new generated dataset contained variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

The code was written based on the instruction of this assignment The steps are 
1. Read necessary activity, subject and  Features data
2. Merge Training and Test dataset to create a single dataset
3. Extract only the measurements on the mean and standard deviation for each measurement
4. Use descriptive activity names to name the activities in the data set
5. Appropriately label the data set with descriptive variable names
6. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
