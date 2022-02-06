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

## Plot 2
png("plot2.png")
with(power_subset,plot(Date_Time,Global_active_power, type = "l" ,  xlab = "" , ylab = "Global Active Power (kilowatts)"))

dev.off()