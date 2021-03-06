###Loading the data###
library(data.table)
library(lubridate)

power <- fread("household_power_consumption.txt", select = 1)    # load only the date 
date <- dmy(power[[1]])         # convert character to date
index <- which(date >= "2007-02-01" & date <= "2007-02-02")     # get the index which is between two days
power <- fread("household_power_consumption.txt", skip = index[1], nrows = length(index))    #load appointed data
rm(list = c("date", "index"))

header <- fread("household_power_consumption.txt", nrows = 1, header = FALSE)
names(power) <- as.vector(as.matrix(header[1,]))
rm(list = "header")
power$Date <- dmy(power$Date)

##PLOT3##
png("plot3.png")
with(power, plot(as.POSIXct(paste(Date,Time), tz = "GMT"), Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(power, points(as.POSIXct(paste(Date,Time)), Sub_metering_2, pch = 17, cex = 0))
with(power, lines(as.POSIXct(paste(Date,Time)), Sub_metering_2, col = "red", lty = 1))
with(power, points(as.POSIXct(paste(Date,Time)), Sub_metering_3, pch = 17, cex = 0))
with(power, lines(as.POSIXct(paste(Date,Time)), Sub_metering_3, col = "blue", lty = 1))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1), cex = 0.7)
dev.off()
