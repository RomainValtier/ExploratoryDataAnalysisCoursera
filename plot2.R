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
plot2.data <- read.csv(fileNAME, header = TRUE, sep = ";", na.strings = "?")

# 2. Convert Date
plot2.data$Date <- as.Date(strptime(plot2.data$Date, format = "%d/%m/%Y"))

# 3. Convert Time
library(chron)
plot2.data$Time <- times(plot2.data$Time)

# 4. Select data from 2007-02-01 and 2007-02-02 
plot2.data <- plot2.data[plot2.data$Date >= "2007-02-01" & plot2.data$Date <= "2007-02-02", ]

# 5. Genrate Plot2
png("plot2.png")
Sys.setlocale("LC_TIME", "C")
plot(as.POSIXct(paste(plot2.data$Date, plot2.data$Time)),plot2.data$Global_active_power, type = "l", main = "", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()
