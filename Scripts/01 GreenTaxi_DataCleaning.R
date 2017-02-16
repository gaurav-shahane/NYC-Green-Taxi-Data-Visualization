setwd("C:\\Users\\gaura\\Documents\\MIM - UMCP\\3rd Sem\\Visualization\\Final Project\\data")

file <- "green_tripdata_2016-06.csv"

#Read DataFile and Omit NAs
greenDf<- read.csv(file, stringsAsFactors = FALSE)
names(greenDf)
greenDf <- greenDf[-17]
green_sample <- na.omit(greenDf)

remove(greenDf)
