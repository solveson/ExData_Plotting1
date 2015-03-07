### EDA, Project 1

# Read entire power data file into temporary object
t <- read.table(file = "household_power_consumption.txt",
  header = TRUE, sep = ";", na.strings = c("?", "NA") )

# Copy dates of interest, remove temp object
d <- t[(t$Date == '1/2/2007' | t$Date == '2/2/2007'), ]
remove(t)

# Create POSIXlt datetime field from Date & Time factors
d$datetime <- (strptime(paste(d$Date, d$Time), 
  format = "%d/%m/%Y %H:%M:%S") )


## Plot 2, Line graph, Datetime vs Global Active Power
png(filename = "plot2.png", width = 480, height = 480)
plot(d$datetime, d$Global_active_power, type = "l",
  xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()

