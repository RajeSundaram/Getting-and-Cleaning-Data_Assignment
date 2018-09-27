
library(dplyr)
# Read nessary data - Activity Data
Activity_Train  <- read.table("./UCI HAR Dataset/train/Y_train.txt", header = FALSE)
Activity_Test<- read.table("./UCI HAR Dataset/test/Y_test.txt" , header = FALSE)

# Read nessary data - Features Data
Features_Train  <- read.table("./UCI HAR Dataset/train/X_train.txt", header= FALSE)
Features_Test <- read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Read nessary data - Subject Data
Subject_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt", header =  FALSE)
Subject_Test  <- read.table("./UCI HAR Dataset/test/subject_test.txt", header= FALSE)



##1.Merge the training and the test sets to create one data set.

Activity_Data<- rbind(Activity_Train, Activity_Test)
Subject_Data <- rbind(Subject_Train, Subject_Test)
Features_Data<- rbind(Features_Train, Features_Test)

names(Subject_Data)<-c("subject")
names(Activity_Data)<- c("activity")

# Read Feature names
Features_Names <- read.table("./UCI HAR Dataset/features.txt", header = FALSE)
names(Features_Data)<- Features_Names$V2

# create Single data set named Merged_Data
Combine_Data <- cbind(Subject_Data , Activity_Data)
Merged_Data <- cbind(Features_Data, Combine_Data)

#str(Merged_Data) - to check after Merge


##2Extract only the measurements on the mean and standard deviation for each measurement.

FeatureNames_Subset<-Features_Names$V2[grep("mean\\(\\)|std\\(\\)", Features_Names$V2)]


selected_Names<-c(as.character(FeatureNames_Subset), "subject", "activity" )

Merged_Data <-subset(Merged_Data,select=selected_Names)

#str(Merged_Data) - to check after Subset



##3 Use descriptive activity names to name the activities in the data set

# Read Activity Labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt" , header = FALSE)

Merged_Data$activity<-factor(Merged_Data$activity);
Merged_Data$activity<- factor(Merged_Data$activity,labels=as.character(activityLabels$V2))

#head(Merged_Data$activity,60) - to check data set for activity names

##4 Appropriately label the data set with descriptive variable names.

#names(Merged_Data) - To verify before replacement 

names(Merged_Data)<- gsub("std", "Standard Deviation", names(Merged_Data))
names(Merged_Data)<- gsub("mean", "Mean", names(Merged_Data))
names(Merged_Data)<-gsub("^t", "Time", names(Merged_Data))
names(Merged_Data)<-gsub("Acc", "Accelerometer", names(Merged_Data))
names(Merged_Data)<-gsub("Gyro", "Gyroscope", names(Merged_Data))
names(Merged_Data)<-gsub("^f", "Frequency", names(Merged_Data))
names(Merged_Data)<-gsub("Mag", "Magnitude", names(Merged_Data))
names(Merged_Data)<-gsub("BodyBody", "Body", names(Merged_Data))


#Replace std with Standard Deviation
#Replace mean with Mean
# Replace prefix with Time
#Replace Acc with Accelerometer
#Replace Gyro with Gyroscope
#Replace prefix f with Frequency
#Replace Mag with Magnitude
#Replace BodyBody with Body

#names(Merged_Data) - To verify after replacement 


##  create a second, independent tidy data set with the average of each variable for each activity and each subject.
Merged_Data1<-aggregate(. ~subject + activity, Merged_Data, mean)
Merged_Data1<-Merged_Data1[order(Merged_Data1$subject,Merged_Data1$activity),]
write.table(Merged_Data1, file = "./UCI HAR Dataset/tidydataset.txt",row.name=FALSE)



# Generate Codebook


df<-read.table("./UCI HAR Dataset/tidydata.txt", header=TRUE)


install.packages("dataMaid")

library(dataMaid)


makeCodebook(df, vol = "", reportTitle = "Code Book for Tidy Data set", file = "TidyData_Codebook.Rmd")



