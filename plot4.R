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
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with(data_ft,{
  plot(data_ft$Time,as.numeric(as.character(data_ft$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
  plot(data_ft$Time,as.numeric(as.character(data_ft$Voltage)), type="l",xlab="datetime",ylab="Voltage")
  plot(data_ft$Time,data_ft$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
  with(data_ft,lines(Time,as.numeric(as.character(Sub_metering_1))))
  with(data_ft,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
  with(data_ft,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
  legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
  plot(data_ft$Time,as.numeric(as.character(data_ft$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})
dev.off()
  