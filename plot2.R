## check zip file is present and download if not
if (file.exists("household_power_consumption.zip") == FALSE){
  fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileurl, destfile = "./household_power_consumption.zip")
  }
data <- read.table(unzip("household_power_consumption.zip"),header = TRUE, na.strings="?",sep = ";")

## Coerce "Date" into Date format, create dataframe, merge "Date" with "Time" and reformat into POSIXct class    
data$Date <- as.Date(data$Date, format ="%d/%m/%Y")
df <- data[data$Date == "2007-02-01" | data$Date == "2007-02-02",]
df$Date <- paste(df$Date, df$Time)
df$Date <- strptime(df$Date, format = "%Y-%m-%d %H:%M:%S")

## Create plot2 and copy as PNG file
png("plot2.png", width=480, height=480) 
plot(df$Date,df$Global_active_power, type = "l", main = "Global Active Power",ylab = "Global Active Power (kilowatts)")
dev.off()