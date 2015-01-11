library(dplyr)
# read dataset into variable "hp"
hp <-read.table("household_power_consumption.txt", header=T, sep = ";", na.strings = "?", col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), stringsAsFactors=F)
# filter dataset to include only dates 2007-02-01 and 2007-02-02
hp <- filter(hp, Date=="1/2/2007"|Date=="2/2/2007")
# convert Date and Time variable into single variable "Date.Time" of class POSIXct
datetime <- paste(hp$Date, hp$Time, sep = " ")
datetime <- strptime(datetime, format = "%d/%m/%Y %H:%M:%S")
hp$datetime <- datetime
#plots
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#Global Active Power plot
with(hp, plot(datetime, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power"))
#Voltage plot
with(hp, plot(datetime, Voltage, type = "l"))
#Energy sub-metering plot
with(hp, {
  plot(c(datetime, datetime, datetime), c(Sub_metering_1, Sub_metering_2, Sub_metering_3  ), type = "n", xlab = "", ylab = "Energy sub metering")
  lines(datetime, Sub_metering_1, col="black")
  lines(datetime, Sub_metering_2, col="red")
  lines(datetime, Sub_metering_3, col="blue")
  legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), lty=1)
})
#Global reactive power plot
with(hp, plot(datetime, Global_reactive_power, type = "l"))
dev.off()