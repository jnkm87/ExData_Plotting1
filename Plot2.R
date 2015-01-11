library(dplyr)
# read dataset into variable "hp"
hp <-read.table("household_power_consumption.txt", header=T, sep = ";", na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), stringsAsFactors=F)
# filter dataset to include only dates 2007-02-01 and 2007-02-02
hp <- filter(hp, Date=="1/2/2007"|Date=="2/2/2007")
# convert Date and Time variable into single variable "Date.Time" of class POSIXct
datetime <- paste(hp$Date, hp$Time, sep = " ")
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
hp$datetime <- datetime
#plot line graph and save as plot2.png
png("plot2.png", width = 480, height = 480)
with(hp, 
  plot(datetime, Global_active_power, type = "l",
  xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()