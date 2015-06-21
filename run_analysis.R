run_analysis<-function(){
  ## load dplyr library
  library(dplyr)
  wd<-getwd()
  
  ## Load data from files
  X_test <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", sep=""), quote="\"")
  y_test <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", sep=""), quote="\"")
  X_train <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", sep=""), quote="\"")
  y_train <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", sep=""), quote="\"")
  subject_test <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", sep=""), quote="\"")
  subject_train <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", sep=""), quote="\"")
  activity_labels <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", sep=""), quote="\"")
  features <- read.table(paste(wd,"/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", sep=""), quote="\"")
  
  ## bind subject id's to device data frames
  test<-cbind(subject_test, y_test, X_test)
  train<-cbind(subject_train, y_train, X_train)
  
  ## bind the two data sets together
  data<-rbind(test, train)
  
  ## replace the column names with the names contained as records in the other data frames
  colnames(data)<-c("subject", "activity", as.vector(features[,2]))
  
  ## drop duplicate columns
  data <- data[ !duplicated(names(data)) ]
  
  ## create vector of clean column names for final set of columns
  clst<-filter(features,grepl('std|mean',V2))
  clst<-as.vector(clst[,2])
  clst<-c("subject", "activity", clst)
  clst<-make.names(clst)
  clst<-clst[!grepl("Freq", clst)]
  
  ## Clean column names
  colnames(data)<-make.names(colnames(data))
  ## drop columns that do not contain mean or stddev data
  data<-data[,clst]
  ## Replace activity id's with activity names from the activity labels data frame
  data<-merge(activity_labels, data, by.x="V1", by.y="activity")
  colnames(data)[2]<-"activity"
  data<-select(data,-matches("V1"))
  data<-select(data, subject, everything())
  
  ## Create tidy data set
  tdata<-aggregate(data[3:68], by=list(subject=data$subject,activity=data$activity), FUN="mean")
  
  ## Write tidy data to file
  write.table(tdata, file="tidy_data.txt", row.names=FALSE)
}