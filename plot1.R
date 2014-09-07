# Exploratory Data Analysis #
# Project1: Plot1

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./power_Consumption.zip", method="curl")
unzip("power_consumption.zip")
temp<-read.table("household_power_consumption.txt",header=TRUE, sep=";", stringsAsFactors = FALSE, nrow=5)
classes<-sapply(temp,class)
household_power_consumption<-read.table("household_power_consumption.txt",header=TRUE, sep=";", stringsAsFactors = FALSE,  colClasses=classes, na.strings="?")
household_power_consumption$dateTime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), "%d/%m/%Y %H:%M:%S")
household_power_consumption$Date <- as.Date(household_power_consumption$Date, "%d/%m/%Y")
filter<-as.Date("01/02/2007", "%d/%m/%Y")
subset_HPC <-subset(household_power_consumption,household_power_consumption$Date==filter | household_power_consumption$Date==filter+1)
par(mfcol=c(1,1))
hist(subset_HPC$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.copy(png, file = "plot1.png")
dev.off()
