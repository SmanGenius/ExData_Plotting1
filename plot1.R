
zipFile <- "exdata_data_household_power_consumption.zip"
outdir <- "dataunzip"

unzip(zipFile, exdir=outdir)

#list.files("dataunzip/")
#read table from the *.txt file
power_cons <- read.table("dataunzip/household_power_consumption.txt",stringsAsFactors=FALSE, header = TRUE,  sep= ";")

#First review od dataser
head(power_cons)

#Modify the format from character to date
power_cons$Date <- as.Date(power_cons$Date, format = "%d/%m/%Y")

#confirm the data format as date
str(power_cons)

#filter the day requsting
power_cons_2 <- subset(power_cons, Date >= "2007-02-01" & Date <= "2007-02-02")

#Delete the rows that hace "?" it meaning NA
power_cons_2 <- power_cons_2[!(power_cons_2$Global_active_power == "?"),]

#modify the class of column to double 
power_cons_2$Global_active_power <- as.double(power_cons_2$Global_active_power)

#plot a histogram as request
hist(power_cons_2$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power(kilowatts)", ylab = "Frecuency")


