setwd('C:\\Users\\lywen\\Desktop\\UCI HAR Dataset')
##Merges the training and the test sets to create one data set.
##Extracts only the measurements on the mean and standard deviation for each measurement. 
##Uses descriptive activity names to name the activities in the data set
##Appropriately labels the data set with descriptive variable names. 
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

test=read.table('test/X_test.txt')
train=read.table('train/X_train.txt')
y_test=read.table('test/y_test.txt')
y_train=read.table('train/y_train.txt')
activity_labels=read.table('activity_labels.txt')
##Merges the training and the test sets to create one data set.
data=rbind(train,test)
##Extracts only the measurements on the mean and standard deviation for each measurement. 
measurement=data.frame(mean=apply(data,1,mean),sd=apply(data,1,sd))
##Uses descriptive activity names to name the activities in the data set
activity=activity_labels[rbind(y_train,y_test)[,1],2]
##Appropriately labels the data set with descriptive variable names.
features=read.table('features.txt')
names(data)=features[,2]
##Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
subject_test=read.table('test/subject_test.txt')
subject_train=read.table('train/subject_train.txt')
subject=factor(rbind(subject_train,subject_test)[,1])
data=data.frame(activity=activity,subject=subject,data=data)
newdata=aggregate(data[,c(-1,-2)],by=list(activity=data[,1],subject=data[,2]),mean)

write.table(newdata,'data.txt',row.name=FALSE)



