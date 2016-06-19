## The following code peforms the following steps
## 1. Reads the downloaded file from the working dir
## 2. Reads the ";" separated file into a data frame
## 3. Filters the data for the specified 2 days of Feb 2007
## 4. Plots a global active power v/s time readings for the 2 days and saves it to plot2.png file

library(dplyr)
setwd('~/data-science-projects/')
downloadFile <- "./household_power_consumption.txt"
allData <- read.table(downloadFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
filteredData <- filter (allData, Date %in% c("1/2/2007","2/2/2007"))

dateTime <- strptime(paste(filteredData$Date, filteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
globalActivePower <- as.numeric(filteredData$Global_active_power)
png("plot2.png", width=480, height=480)
plot(dateTime, globalActivePower, col="red", type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()