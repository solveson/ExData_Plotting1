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


## Plot 4, Four distinct graphs in 2x2 matrix
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
with(d,
  { 
    # top left; time vs active power
    plot(datetime, Global_active_power, type = "l",
         xlab = "", ylab = "Global Active Power")
    
    # top right; time vs voltage
    plot(datetime, Voltage, type = "l")
    
    # bottom left; time vs three sub meters
    plot(d$datetime, 
         apply(cbind(d$Sub_metering_1, d$Sub_metering_2, d$Sub_metering_3),
               1, max),
         type = "n",
         xlab = "", ylab = "Energy sub metering")
    points(d$datetime, d$Sub_metering_1, type = "l", col = "black")
    points(d$datetime, d$Sub_metering_2, type = "l", col = "red"  )
    points(d$datetime, d$Sub_metering_3, type = "l", col = "blue" )
    legend("topright", lty = 1, bty = "n",
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )
    
    # bottom right; time vs reactive power
    plot(datetime, Global_reactive_power, type = "l")        
  }     
)
dev.off()
