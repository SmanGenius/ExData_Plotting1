library(tidyverse)
library(janitor)

#Open file
cons_con_p2 <- read.table("dataunzip/household_power_consumption.txt",stringsAsFactors=FALSE, header = TRUE,  sep= ";")


head(cons_con_p2)

str(cons_con_p2)

cons_con_p2 <- mutate(cons_con_p2, complete_date= paste(cons_con_p2$Date,  cons_con_p2$Time))
#Convert data type
cons_con_p2$complete_date <- strptime(cons_con_p2$complete_date, format = "%d/%m/%Y %H:%M:%S")#" %A %d/%m/%Y %H:%M:%S"
cons_con_p2$Date <- as.Date(cons_con_p2$Date, format = "%d/%m/%Y")

#change from character to numeric
cons_con_p2$Sub_metering_1 <- as.numeric(cons_con_p2$Sub_metering_1)
cons_con_p2$Sub_metering_2 <- as.numeric(cons_con_p2$Sub_metering_2)
cons_con_p2$Voltage <- as.numeric(cons_con_p2$Voltage)
cons_con_p2$Global_reactive_power <- as.numeric(cons_con_p2$Global_reactive_power)

#filter date
cons_con_p2 <- subset(cons_con_p2, Date >= "2007-02-01" & Date <= "2007-02-02")

#multiple plot 2 row * 2 

png("plot4.png", width = 480, height = 480 ) 
par(mfrow=c(2,2))

#plot1
hist(power_cons_2$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)",main = '', ylab = "Frecuency")

#plot2
plot(cons_con_p2$complete_date, cons_con_p2$Voltage, type = "l", xlab = "datetime", ylab = "Voltage", labels= FALSE)
axis(side=2 ,at=c(234,238,242,246),labels=c('234','238','242','246')) 
axis(side=1 ,at=c(1170309600,1170395940,1170482340),labels=c('Thu','Fri','Sat')) 

#plot3
plot(cons_con_p2$complete_date,cons_con_p2$Sub_metering_1, type = "l", xlab='' , ylab = "Energy sub metering", labels = FALSE)
lines(cons_con_p2$complete_date,cons_con_p2$Sub_metering_2, col = "red")
lines(cons_con_p2$complete_date,cons_con_p2$Sub_metering_3, col= "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty = 1,
       col = c("black","red","blue"),
       lwd = 2)
axis(side=2 ,at=c(0,10,20,30),labels=c('0','10','20','30')) 
axis(side=1 ,at=c(1170309600,1170395940,1170482340),labels=c('Thu','Fri','Sat')) 
#plot4
plot(cons_con_p2$complete_date, cons_con_p2$Global_reactive_power, type = "l", xlab = "datetime", labels= FALSE, ylab = "Global_reactive_power" )
axis(side=2 ,at=c(0,0.1,0.2,0.3,0.4,0.5),labels=c('0.0','0.1','0.2','0.3','0.4','0.5')) 
axis(side=1 ,at=c(1170309600,1170395940,1170482340),labels=c('Thu','Fri','Sat')) 

dev.off()

