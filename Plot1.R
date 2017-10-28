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
	
	##Plot Histogram
	hist(y$Global_active_power,col="Red",xlab = "Global active power(Kilowatts)",main = "Global Active Power")
	##Save plot
	dev.copy(png, file="plot1.png", width=480, height=480)
	dev.off()
	cat("Plot1.png has been saved in", getwd())
	