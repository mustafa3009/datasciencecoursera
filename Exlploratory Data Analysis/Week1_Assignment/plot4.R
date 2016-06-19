## The following code peforms the following steps
## 1. Reads the downloaded file from the working dir
## 2. Reads the ";" separated file into a data frame
## 3. Filters the data for the specified 2 days of Feb 2007
## 4. Captures the 3 submeter readings for the 2 days. 
## 5. Plots the following 4 plots 
##    a. time v/s global active power
##    b. time v/s voltage
##    c. time v/s the 3 submeter readinds
##    d. time v/s flobal reactive power.


## This script
library(dplyr)
setwd('~/data-science-projects/')
downloadFile <- "./household_power_consumption.txt"
allData <- read.table(downloadFile, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".", na.strings = "?")
filteredData <- filter (allData, Date %in% c("1/2/2007","2/2/2007"))

globalActivePower <- as.numeric(filteredData$Global_active_power)
globalReactivePower <- as.numeric(filteredData$Global_reactive_power)
voltage <- as.numeric(filteredData$Voltage)
subMetering1 <- as.numeric(filteredData$Sub_metering_1)
subMetering2 <- as.numeric(filteredData$Sub_metering_2)
subMetering3 <- as.numeric(filteredData$Sub_metering_3)

dateTime <- strptime(paste(filteredData$Date, filteredData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480)
par(mfrow = c(2, 2)) 

plot(dateTime, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

plot(dateTime, voltage, type="l", xlab="datetime", ylab="Voltage")

plot(dateTime, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(dateTime, subMetering2, type="l", col="red")
lines(dateTime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

plot(dateTime, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()
