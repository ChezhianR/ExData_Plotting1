##Download Files
	
	if(!file.exists("./data"))
	{
		dir.create("./data")
	}

	download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="./data/Dataset.zip")

##unzip files 

	unzip(zipfile="./data/Dataset.zip",exdir="./data")
	ref_path <- file.path("./data" )

	x<-read.csv(file.path(ref_path,"household_power_consumption.txt"),  sep=";",stringsAsFactors = FALSE)
	
	##Cast Objects 
	x$Date<-as.Date.character(x$Date, format="%d/%m/%Y")
	x$Global_active_power <- as.numeric(x$Global_active_power)
	x$Global_reactive_power <- as.numeric(x$Global_reactive_power)
	x$Voltage <- as.numeric(x$Voltage)
	x$Sub_metering_1 <- as.numeric(x$Sub_metering_1)
	x$Sub_metering_2 <- as.numeric(x$Sub_metering_2)
	x$Sub_metering_3 <- as.numeric(x$Sub_metering_3)

	
	##subset 
	y<-x[which(x$Date == "2007-02-01" | x$Date=="2007-02-02" ),]
	
	##Validate 
	unique(y$Date)
	
	##Get Timestamp
	y$TimeStamp <- paste(y$Date,y$Time)

	##
	plot(as.POSIXlt(y$TimeStamp, format="%d/%m/%Y %H:%M:%S"),  y$Sub_metering_1,  type = "l", xlab = "", ylab = "Energy sub metering")
	lines(as.POSIXlt(y$TimeStamp, format="%d/%m/%Y %H:%M:%S"),y$Sub_metering_2, type = "l", col="Red")
	lines(as.POSIXlt(y$TimeStamp, format="%d/%m/%Y %H:%M:%S"),y$Sub_metering_3, type = "l", col="blue")
	legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
	## Save files
	dev.copy(png, file="plot3.png", width=480, height=480)
	dev.off()
