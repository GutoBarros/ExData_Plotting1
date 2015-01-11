## Fourth plot script, project 1 on Exploratory Data Analysis
# Creates the dataset if it doesn't exists

if (!file.exists("./net_data.txt")){
      gross_data <- read.csv("./household_power_consumption.txt", sep=";", 
                             na.strings="?",stringsAsFactors=FALSE)
      datahora <- paste(gross_data$Date,gross_data$Time)
      gross_data <- cbind(gross_data,datahora)
      net_data <- gross_data[(gross_data$Date=="1/2/2007" 
                              | gross_data$Date=="2/2/2007"),]
      net_data$datahora <- strptime(net_data$datahora,
                                    format="%d/%m/%Y %H:%M:%S")
      write.table(net_data, file="net_data.txt", sep="\t")
}else{
      net_data <- read.csv("./net_data.txt", sep="\t", stringsAsFactors=FALSE)
      net_data$datahora <- strptime(net_data$datahora,
                                    format="%Y-%m-%d %H:%M:%S")
}

# Makes the plot

Sys.setlocale("LC_TIME", "English")
png(filename="plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
with (net_data, {plot(datahora, Global_active_power, type = "n",
					ylab="Global Active Power (kilowatts)", xlab="")
				lines(datahora, Global_active_power)
				plot(datahora, Voltage, type = "n",
					ylab="Voltage", xlab="datetime")
				lines(datahora, Voltage)
				plot(datahora, Sub_metering_1, type = "n",
					ylab="Energy sub metering", xlab="")
				lines(datahora, Sub_metering_1, col="black")
				lines(datahora, Sub_metering_2, col="red")
				lines(datahora, Sub_metering_3, col="blue")
				legend("topright", bty="n", lwd=2, col=c("black" ,"red", "blue"),
					legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
				plot(datahora, Global_reactive_power, type = "n",
					ylab="Global_reactive_power", xlab="datetime")
				lines(datahora, Global_reactive_power)
				})
dev.off()