## second plot script, project 1 on Exploratory Data Analysis

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
png("plot2.png",width=480,height=480,units="px")
with(subspower, plot(datahora, Global_active_power, type ="n",
                     ylab="Global Active Power (kilowatts)", xlab=""))
with(subspower, lines(datahora, Global_active_power))
dev.off()