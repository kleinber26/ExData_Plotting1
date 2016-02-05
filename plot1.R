
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
#set margins
#par(mar = c(5,4,4,2))
#create hist
png(filename = "plot1.png", width=480, height=480)
hist(subset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()