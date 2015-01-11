## Third plot script, project 1 on Exploratory Data Analysis
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
png(filename="plot3.png", width = 480, height = 480, units = "px")
with(net_data, plot(datahora, Sub_metering_1, type = "n",
                    ylab="Energy sub metering", xlab=""))
with(net_data, lines(datahora, Sub_metering_1, col="black"))
with(net_data, lines(datahora, Sub_metering_2, col="red"))
with(net_data, lines(datahora, Sub_metering_3, col="blue"))
legend("topright", lwd=2, col=c("black" ,"red", "blue"),
      legend= c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()