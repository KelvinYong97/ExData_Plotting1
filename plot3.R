## load libraries
library(dplyr)

## Download data
if(!("exdata_data_household_power_consumption.zip" %in% dir())) {
    download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" ,
                  destfile = "exdata_data_household_power_consumption.zip")
    unzip(zipfile = "exdata_data_household_power_consumption.zip")
}

## Read data
power_data <- read.table("household_power_consumption.txt",sep = ";",header = TRUE)

## View Data Summary
str(power_data)

## only take 2 days data. 2007-02-01 and 2007-02-02
power_subset <- power_data %>% filter(Date %in% c("1/2/2007", "2/2/2007"))
unique(power_subset$Date)
rm(power_data)

## convert columns to numeric
power_subset[,c(3:9)] <- sapply(power_subset[,c(3:9)], as.numeric)
power_subset$Date_Time <- strptime(paste(power_subset$Date,power_subset$Time), format = "%d/%m/%Y %H:%M:%S")

str(power_subset)

## Plot 3
with(power_subset, {
    plot(Date_Time, Sub_metering_1, ylab = "Energy sub metering", type = "l")
    lines(Date_Time, Sub_metering_2 , col = "Red")
    lines(Date_Time, Sub_metering_3, col = "Blue")
})
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty =1 ,col=c("black","red","blue"))

dev.copy(device = png,file = "plot3.png")
dev.off()