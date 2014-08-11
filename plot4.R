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

par(mfcol=c(2,2), mar=c(4,4,2,2), oma=c(1,1,1,1))

plot(subset_HPC$dateTime,subset_HPC$Global_active_power, type="l", ylab= "Global Active Power (kilowatts)", xlab="")

with(subset_HPC, plot(subset_HPC$dateTime,subset_HPC$Sub_metering_1, type="l", ylab= "Energy Sub metering", xlab=""))
lines(subset_HPC$dateTime,subset_HPC$Sub_metering_2,col="red")
lines(subset_HPC$dateTime,subset_HPC$Sub_metering_3,col="blue")
legend("topright", lty = c(1,1,1),  col = c("black", "red", "blue"), legend = c("Sub_metering_1 ", "Sub_metering_2 ","Sub_metering_3 "), cex=.75, bty="n")

with(subset_HPC, plot(subset_HPC$dateTime,subset_HPC$Voltage, type="l", ylab= "Voltage", xlab="datetime"))

with(subset_HPC, plot(subset_HPC$dateTime,subset_HPC$Global_reactive_power, type="l", ylab= "Global_reactive_power", xlab="datetime"))

dev.copy(png, file = "plot4.png")
dev.off()
