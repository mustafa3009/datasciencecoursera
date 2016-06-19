## The following code peforms the following steps
## 1. Reads the downloaded file from the working dir
## 2. Reads the ";" separated file into a data frame
## 3. Filters the data for the specified 2 days of Feb 2007
## 4. Plots a histogram of the global active power reading and saves it to plot1.png file

library(dplyr)
setwd('~/data-science-projects/')
downloadFile <- "./household_power_consumption.txt"
allData <- read.table(downloadFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
filteredData <- filter (allData, Date %in% c("1/2/2007","2/2/2007"))

globalActivePower <- as.numeric(filteredData$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()