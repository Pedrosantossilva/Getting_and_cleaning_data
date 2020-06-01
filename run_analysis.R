#Read files with labels, id and measures, based on readme.txt information 

##Labels
activity_labels <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/activity_labels.txt")

features <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/features.txt")


##id (subject and activity)
subject_test <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/test/subject_test.txt")

subject_train <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/train/subject_train.txt")

y_test <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/test/y_test.txt")

y_train <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/train/y_train.txt")

##Measures
X_test <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/test/X_test.txt")

X_train <- read.table("C:/Users/pedro/OneDrive/Ambiente de Trabalho/datasciencecoursera/UCI HAR Dataset/train/X_train.txt")


#Variables naming (task 4)
colnames(X_test) <- features[,2]
colnames(X_train) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"
colnames(activity_labels) <- c('activityId','activityType')

#Merge Data (task 1)

##columns
Data_test <- bind_cols(y_test, subject_test, X_test)
Data_train <- bind_cols(y_train, subject_train, X_train)

##Rows
Data <- bind_rows(Data_train, Data_test)

##Extract means and SDs (task2)

Data_means_sd <- select(Data, contains("activityId") | contains("subjectId") | 
                          contains("mean()") | contains("std()"))

##Uses descriptive activity names to name the activities in the data set (task 3)

Data_act <- full_join(activity_labels, Data_means_sd,  by= "activityId")

##Data set with the average of each variable for each activity and each subject (task5)

summary <- Data_act %>% group_by(activityId, subjectId) %>%
  summarise_at(vars(names(Data_act)[4]: names(Data_act)[69]), mean)

#Save
write_csv(summary, "final.csv")
