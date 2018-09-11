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
plot1.data <- read.csv(fileNAME, header = TRUE, sep = ";", na.strings = "?")

# 2. Convert Date
plot1.data$Date <- as.Date(strptime(plot1.data$Date, format = "%d/%m/%Y"))

# 3. Convert Time
library(chron)
plot1.data$Time <- times(plot1.data$Time)

# 4. Select data from 2007-02-01 and 2007-02-02 
plot1.data <- plot1.data[plot1.data$Date >= "2007-02-01" & plot1.data$Date <= "2007-02-02", ]

# 5. Histogram Global Active Power
png("plot1.png")
hist(plot1.data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Gloabl Active Power (kilowatts)")
dev.off()
