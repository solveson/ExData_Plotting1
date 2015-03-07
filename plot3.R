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


  ## Plot 3, Multiple Line graph, datetime vs Sub-meters
png(filename = "plot3.png", width = 480, height = 480)

# Set up plot area & label axes. Use 'apply' to size vertical axis
plot(d$datetime, 
  apply(cbind(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3),
    1, max),
  type = "n",
  xlab = "", ylab = "Energy sub metering")

# Plot the three lines
points(d$datetime, d$Sub_metering_1, type = "l", col = "black")
points(d$datetime, d$Sub_metering_2, type = "l", col = "red"  )
points(d$datetime, d$Sub_metering_3, type = "l", col = "blue" )

# Add legend and close file
legend("topright", lty = 1, 
  col = c("black", "red", "blue"),
  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
dev.off()

