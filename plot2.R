library(tidyverse)
library(janitor)



cons_con_p2 <- read.table("dataunzip/household_power_consumption.txt",stringsAsFactors=FALSE, header = TRUE,  sep= ";")


head(cons_con_p2)

str(cons_con_p2)

cons_con_p2 <- mutate(cons_con_p2, complete_date= paste(cons_con_p2$Date,  cons_con_p2$Time))

cons_con_p2$complete_date <- strptime(cons_con_p2$complete_date, format = "%d/%m/%Y %H:%M:%S")#" %A %d/%m/%Y %H:%M:%S"
cons_con_p2$Date <- as.Date(cons_con_p2$Date, format = "%d/%m/%Y")


cons_con_p2$Global_active_power <- as.numeric(cons_con_p2$Global_active_power)

str(cons_con_p2)

cons_con_p2 <- subset(cons_con_p2, Date >= "2007-02-01" & Date <= "2007-02-02")
Sys.setlocale("LC_TIME", "English")


Sys.time()
Sys.Date()

format(cons_con_p2$complete_date, "%d/%m/%Y %H:%M:%S")#"%a %b %d %X %Y"

cons1 <- cons_con_p2

cons1$complete_date <- as.POSIXlt(cons1$complete_date, format= '%d/%m/%Y %H:%M:%S')#"%a %b %d %X %Y"
cons1$complete_date <- format(cons1$complete_date, format = "%a %d/%m/%Y %H:%M:%S")
str(cons1)

cons_con_p2 <- mutate(cons_con_p2, week_day = weekdays(cons_con_p2$Date))
dev.cur()
png("plot2.png", width = 480, height = 480)

plot(cons1$complete_date,cons1$Global_active_power, type= "l", xlab = "Day", ylab = "GLobal Active Power(Kilowatts)") 
#axis(side = 1, at = c(cons1$complete_date[1],cons1$complete_date[1440],cons1$complete_date[2880]), labels=c("Thu","Fri","Sat"))
axis(side=2 ,at=c(0,2,4,6),labels=c('0','2','4','6')) 
axis(side=1 ,at=c(1170309600,1170395940,1170482340),labels=c('Thu','Fri','Sat')) 
dev.off()










