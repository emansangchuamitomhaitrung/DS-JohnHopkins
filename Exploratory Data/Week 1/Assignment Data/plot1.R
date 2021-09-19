# Reading data
source('~/DS-JohnHopkins/Exploratory Data/Week 1/Assignment Data/read-data.R')

# Plotting using base plotting system and save to a PNG file of 480x480 (pixels)
# First plot: Histogram of Global Active Power
plot1 <- function(dat) {
        png('./Assignment Data/plot1.png', width=480, height=480)
        hist(as.numeric(dat$Global_active_power), col='red', border='black', 
             main='Global Active Power',
             xlab='Global Active Power (kilowatts)',
             ylab='Frequency')
        dev.off()
}