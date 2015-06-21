Coursera Getting and Cleaning Data Course Project
John N Sneller
6/21/2015

The run_analysis function imports several files of data taken from smartphones and aggregaes the mean and standard deviation measurement columns of data. The function assumes the data has been unpacked into the working directory. There is no need to move the individual files from there. The directory tree should look like ; Working Directory
                                                                                        > getdata_projectfiles_UCI HAR Dataset


                                       Function Pseudocode and Descriptions
Load the dplyr library and grab the working directory, then load the relevant data files into like named variables. 

The subject and activity ids are bound to their respective data so that they will follow the correct records through the following operations. 

The two data sets are then bound into a single data frame

Column names are retrieved from the features data and used, along with the titles "subject" and "activity" to name the columns in order. This is the presumed layout of the data based on the number of columns compared to the number of records in the features data. The angle columns are also removed as the pattern matching naturally excludes them. I felt this was appropriate for the same reason as with the Frequency columns. 

Duplicate names were found to cause problems and so those columns are removed. None of the columns removed meet the criteria for retention.

Generate vector with cleaned column names for final column set. I decided to remove the Frequency variables as the names indicate they are calculations of calculations and therefore not the same information as the other columns, though derived from the same data. 

Clean Column names in working data frame so they match with above vector

Subset working data using clst vector from above

Replace the activity ids with the labels from the activity_labels data frame. Merge adds a column which I must then rename and remove the id column. Because this leaves the activity and subject columns out of order I then reorder the columns. This is a quick fix due to time constraints.

Aggregate the data from column 3 to 68, leaving the id columns out of the aggregation, and place in a new data frame.

Write the tidy data to a file called "tidy_data.txt".


I have included code to read the file into a variable called tidy_data for the markers convenience. I want to thank the TA's for the suggestion.

tidy_data <- read.table("~/tidy_data.txt", header=TRUE, quote="\"")
