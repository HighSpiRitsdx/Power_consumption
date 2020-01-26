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


##PLOT1##
png("plot1.png")
with(power, hist(Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)"))
dev.off()
