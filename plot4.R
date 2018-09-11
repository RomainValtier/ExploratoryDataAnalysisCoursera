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
plot4.data <- read.csv(fileNAME, header = TRUE, sep = ";", na.strings = "?")

# 2. Convert Date
plot4.data$Date <- as.Date(strptime(plot4.data$Date, format = "%d/%m/%Y"))

# 3. Convert Time
library(chron)
plot4.data$Time <- times(plot4.data$Time)

# 4. Select data from 2007-02-01 and 2007-02-02 
plot4.data <- plot4.data[plot4.data$Date >= "2007-02-01" & plot4.data$Date <= "2007-02-02", ]

str(plot4.data)

# 5. Generate Plot4
Sys.setlocale("LC_TIME", "C")

png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))

plot(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Global_active_power, type = "l", main = "", ylab = "Global Active Power (kilowatts)", xlab = "")

plot(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Voltage, type = "l", main = "", ylab = "Voltage", xlab = "datetime")

plot(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Sub_metering_1, type = "l", col = "black", main = "", ylab = "Energy sub metering", xlab = "")
lines(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Sub_metering_2, type = "l", col = "red")
lines(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1)

plot(as.POSIXct(paste(plot4.data$Date, plot4.data$Time)),plot4.data$Global_reactive_power , type = "l", main = "", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
