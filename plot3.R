setwd("C:\\Users\\s8310533\\Documents\\GitHub\\ExploratoryDataAnalysisCoursera")

# 0. Get data

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileNAME <- "household_power_consumption.zip"
if (!file.exists(fileNAME)){
        download.file(fileURL, fileNAME)
}  
if (!file.exists("household_power_consumption.txt")) { 
        unzip(fileNAME)
}
fileNAME <- "household_power_consumption.txt"

# 1. Load data
plot3.data <- read.csv(fileNAME, header = TRUE, sep = ";", na.strings = "?")

# 2. Convert Date
plot3.data$Date <- as.Date(strptime(plot3.data$Date, format = "%d/%m/%Y"))

# 3. Convert Time
library(chron)
plot3.data$Time <- times(plot3.data$Time)

# 4. Select data from 2007-02-01 and 2007-02-02 
plot3.data <- plot3.data[plot3.data$Date >= "2007-02-01" & plot3.data$Date <= "2007-02-02", ]

str(plot3.data)

# 5. Generate Plot3
Sys.setlocale("LC_TIME", "C")

png("plot3.png", width = 480, height = 480)

plot(as.POSIXct(paste(plot3.data$Date, plot3.data$Time)),plot3.data$Sub_metering_1, type = "l", col = "black", main = "", ylab = "Energy sub metering", xlab = "")
lines(as.POSIXct(paste(plot3.data$Date, plot3.data$Time)),plot3.data$Sub_metering_2, type = "l", col = "red")
lines(as.POSIXct(paste(plot3.data$Date, plot3.data$Time)),plot3.data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

dev.off()
