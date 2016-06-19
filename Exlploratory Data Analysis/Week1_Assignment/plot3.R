## The following code peforms the following steps
## 1. Reads the downloaded file from the working dir
## 2. Reads the ";" separated file into a data frame
## 3. Filters the data for the specified 2 days of Feb 2007
## 4. Captures the 3 submeter readings for the 2 days. 
## 5. Plots the 3 submeter v/s time readings for the 2 days and saves it to plot3.png file
## 6. Displays a legend at the top right indicating the different colors used. 


library(dplyr)
setwd('~/data-science-projects/')
downloadFile <- "./household_power_consumption.txt"
allData <- read.table(downloadFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
filteredData <- filter (allData, Date %in% c("1/2/2007","2/2/2007"))

subMetering1 <- as.numeric(filteredData$Sub_metering_1)
subMetering2 <- as.numeric(filteredData$Sub_metering_2)
subMetering3 <- as.numeric(filteredData$Sub_metering_3)

png("plot3.png", width=480, height=480)
dateTime <- strptime(paste(filteredData$Date, filteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
plot(dateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()