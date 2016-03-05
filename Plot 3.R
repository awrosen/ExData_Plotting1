# Setting the WD
setwd("~/Desktop/Data Science/Exploratory Data Analysis/week 1/ExData_Plotting1")
getwd()

# Getting the data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header=T,sep=";")
unlink(temp)

#Cleaning the data
names(data)
data$Date<-as.Date(data$Date,format="%d/%m/%Y")
df<-data[(data$Date=="2007-02-01") | (data$Date=="2007-02-02"),]
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))
df$Voltage <- as.numeric(as.character(df$Voltage))
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

#Plot 3
with(df,plot(timestamp,Sub_metering_1,type="l",xlab="",ylab="Energy sub metering"))
with(df,lines(timestamp,Sub_metering_2,col="red"))
with(df,lines(timestamp,Sub_metering_3,col="blue"))
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
