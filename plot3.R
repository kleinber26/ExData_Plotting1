#download data set
if (!file.exists("household power consumption.zip")) {
  fileURL <<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, "household power consumption.zip", method = "curl")
}
if(!file.exists("household power consumption")) {
  unzip("household power consumption.zip")
}
#load data set into R
household_power_consumption <<- read.table("household_power_consumption.txt", 
                                           sep=";", header = TRUE, na.strings = "?")
#subset data from 2007-02-01 and 2007-02-02
subset <- subset(household_power_consumption, Date == "1/2/2007" | Date == "2/2/2007")
#create a new column with Date and Time
subset$DateTime <- strptime(paste(subset$Date, subset$Time), "%d/%m/%Y %H:%M:%S")
#convert Sub_metering_1, 2 and 3 to numeric
subset$Sub_metering_1 <- as.numeric(as.character(subset$Sub_metering_1))
subset$Sub_metering_2 <- as.numeric(as.character(subset$Sub_metering_2))
subset$Sub_metering_3 <- as.numeric(as.character(subset$Sub_metering_3))
#create plot
png(filename = "plot3.png", width=480, height=480)
plot(subset$DateTime, subset$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subset$DateTime, subset$Sub_metering_2, col="red")
lines(subset$DateTime, subset$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()