#The data for this file came from from the UC Irvine Machine Learning Repository.
#It is called the "Individual household electric power consumption Data Set"
#Description: Single household electrical energy consumption rate, sampled every
#minute for the first two full days of February, 2007. See below for descriptions
#of the variables.

#Source URL:
#https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Downloaded: Mon Aug 20th 2023

#Description of Variables
#datetime: the combined information from the Date and Time variables, but in
#POSIXct format. The value is the number of seconds since 1970-01-01 00:00:00.000
#Date: Date in format dd/mm/yyyy
#Time: time in format hh:mm:ss
#Global_active_power: household global minute-averaged active power (in kilowatts)
#Global_reactive_power: household global minute-averaged reactive power (in kilowatts)
#Voltage: minute-averaged voltage (in volts)
#Global_intensity: household global minute-averaged current intensity (in amperes)
#Sub_metering_1: energy sub-metering No. 1 (in watt-hours of active energy). 
#It corresponds to the kitchen, containing mainly a dishwasher, an oven and a 
#microwave (hot plates are not electric but gas powered).
#Sub_metering_2: energy sub-metering No. 2 (in watt-hours of active energy). 
#It corresponds to the laundry room, containing a washing-machine, a tumble-drier, 
#a refrigerator, and a light.
#Sub_metering_3: energy sub-metering No. 3 (in watt-hours of active energy). It 
#corresponds to an electric water-heater and an air-conditioner.

header<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
                   na.strings="?",nrows=1)
df<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
               na.strings="?",skip=66636,nrows=2881)
names(df)<-names(header)
library(lubridate)
datetime <- dmy_hms(paste(df$Date,"_",df$Time,sep=""))
df <- cbind(datetime,df)
for(i in 4:9){
  df[[i]]<-as.numeric(df[[i]])
}
#png(file="T2p4.png", width=480, height=480) #Creates a 480 x 480 pixel .png.par(mfrow=c(2,2))
par(mfrow = c(2,2))
plot(x=df$datetime,y=df$Global_active_power,type="l",family="sans",xlab="",
     ylab="Global Active Power (kilowatts)",xaxt="n")
axis(1,at=c(df$datetime[1],df$datetime[1441],df$datetime[2881]),labels=c("Thu","Fri","Sat"))
plot(x=df$datetime, y=df$Voltage, type="l", family="sans", xlab="datetime",
     ylab="Voltage", xaxt="n")
axis(1,at=c(df$datetime[1],df$datetime[1441],df$datetime[2881]),labels=c("Thu","Fri","Sat"))
plot(x=df$datetime,y=df$Sub_metering_1,type="l",family="sans",xlab="",
     ylab="Energy sub metering",xaxt="n")
lines(x=df$datetime,y=df$Sub_metering_2,type="l",col="red")
lines(x=df$datetime,y=df$Sub_metering_3,type="l",col="blue")
axis(1,at=c(df$datetime[1],df$datetime[1441],df$datetime[2881]),
     labels=c("Thu","Fri","Sat"))
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = (c("black","red","blue")),lty=1,lwd=2)
plot(x=df$datetime, y=df$Global_reactive_power, type="l", family="sans", xlab="datetime",
     ylab="Voltage", xaxt="n")
axis(1,at=c(df$datetime[1],df$datetime[1441],df$datetime[2881]),labels=c("Thu","Fri","Sat"))
dev.off()

