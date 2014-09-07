# Exploratory Data Analysis #
# Project1: Plot3

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
with(subset_HPC, plot(subset_HPC$dateTime,subset_HPC$Sub_metering_1, type="l", ylab= "Energy Sub metering", xlab=""))
lines(subset_HPC$dateTime,subset_HPC$Sub_metering_2,col="red")
lines(subset_HPC$dateTime,subset_HPC$Sub_metering_3,col="blue")
leg<-c("Sub_metering_1", "Sub_metering_2","Sub_metering_3")
legend("topright", lty = c(1,1,1),  col = c("black", "red", "blue"), legend = leg, xjust=0, cex=.9, merge = TRUE)
dev.copy(png, file = "plot3.png",width = 480, height = 480, units = "px", pointsize = 8,
bg = "white", res = NA)
dev.off()
