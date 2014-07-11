## fourth plot script, project 1 on Exploratory Data Analysis

# Creates the dataset, if it doesn't exists

if (!file.exists("./subspower.txt")){
      power <- read.csv("./household_power_consumption.txt", sep=";", 
                        stringsAsFactors=FALSE, colClasses=c(rep("character",2),
                                                             rep("numeric",7)), na.strings="?")
      datahora <- paste(power$Date,power$Time)
      power <- cbind(power,datahora)
      power$datahora <- strptime(power$datahora, format="%d/%m/%Y %H:%M:%S")
      subspower<-subset(power,(Date=="1/2/2007" | Date=="2/2/2007"))
      write.table(subspower, file="subspower.txt", sep="\t")
}else{
      subspower <- read.table("./subspower.txt", sep="\t", stringsAsFactors=FALSE)
      subspower$datahora <- strptime(subspower$datahora, format="%Y-%m-%d %H:%M:%S")     
}

#makes the plot 

Sys.setlocale("LC_TIME", "English")
png("plot4.png",width=480,height=480,units="px")
par(mfrow = c(2,2))
with(subspower,{ plot(datahora, Global_active_power, type ="n",
                      ylab="Global Active Power", xlab="")
                 lines(datahora, Global_active_power)
                 plot(datahora, Voltage, type ="n",
                      ylab="Voltage", xlab="datetime")
                 lines(datahora,Voltage)
                 plot(datahora, Sub_metering_1, type= "n", ylab="Energy sub metering",xlab="")
                 lines(datahora, Sub_metering_1, col = "black")
                 lines(datahora, Sub_metering_2, col = "red")
                 lines(datahora, Sub_metering_3, col = "blue")
                 legend("topright", lwd=2, col=c("black" ,"red", "blue"),
                        legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
                 plot(datahora, Global_reactive_power, type="n", xlab="datetime",
                      ylab="Global_reactive_power")
                 lines(datahora, Global_reactive_power)
})
dev.off()