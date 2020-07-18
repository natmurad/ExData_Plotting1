#Setting time to english
Sys.setlocale(category="LC_TIME", locale="en_US.UTF-8")
#Reading and subsetting the file
data <- read.csv("household_power_consumption.txt", h=TRUE, sep = ";", dec = ".", na.strings="?")
data_ft <- subset(data, Date=="1/2/2007" | Date=="2/2/2007")
rm(data)
#Formating Date and Time
data_ft$Time <- strptime(data_ft$Time, format = "%H:%M:%S")
data_ft$Date <- as.Date(data_ft$Date, format="%d/%m/%Y")
data_ft[1:1440,"Time"] <- format(data_ft[1:1440,"Time"],"2007-02-01 %H:%M:%S")
data_ft[1441:2880,"Time"] <- format(data_ft[1441:2880,"Time"],"2007-02-02 %H:%M:%S")
#Creating the plot
png(filename = "plot3.png", width = 480, height = 480, units = "px")

plot(data_ft$Time, c(data_ft$Sub_metering_1), ylab="Energy sub metering", xlab = "", type = "l")
lines(data_ft$Time, data_ft$Sub_metering_2, ylab="Energy sub metering", type = "l", col = "red")
lines(data_ft$Time, data_ft$Sub_metering_3, ylab="Energy sub metering", type = "l", col = "blue")
legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off() 
  