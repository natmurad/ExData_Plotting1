#Reading and subsetting the file
data <- read.csv("household_power_consumption.txt", h=TRUE, sep = ";", dec = ".", na.strings="?")
data_ft <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")
rm(data)
#Formating Date and Time
data_ft$Time <- strptime(data_ft$Time, format = "%H:%M:%S")
data_ft$Date <- as.Date(data_ft$Date, format="%d/%m/%Y")
data_ft[1:1440,"Time"] <- format(data_ft[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_ft[1441:2880,"Time"] <- format(data_ft[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

#Creating the graph
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(data_ft$Global_active_power, col="red", main = "Global Active Power", 
     xlab= "Global Active Power (kilowatts)")

dev.off() 
  