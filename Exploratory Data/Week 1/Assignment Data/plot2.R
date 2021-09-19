# Reading data
source('~/DS-JohnHopkins/Exploratory Data/Week 1/Assignment Data/read-data.R')

# Plotting using base plotting system and save to a PNG file of 480x480 (pixels)
# Second plot: Line graph representing the variation of Global Active Power through the days
plot2 <- function(dat) {
        png('./Assignment Data/plot2.png', width=480, height=480)
        with(dat, plot(FullDate, Global_active_power,
                       type='l',
                       xlab='',
                       ylab='Global Active Power (kilowatts)'))
        dev.off()
}