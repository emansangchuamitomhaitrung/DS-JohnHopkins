# Reading data
source('~/DS-JohnHopkins/Exploratory Data/Week 1/Assignment Data/read-data.R')

# Plotting using base plotting system and save to a PNG file of 480x480 (pixels)
# Third plot: Line graphs representing the variations of 3 energy sub meterings over the days
plot3 <- function(dat) {
        png('./Assignment Data/plot3.png', width=480, height=480)
        with(dat, plot(FullDate, as.numeric(Sub_metering_1), type='l', col='black',
             xlab='',
             ylab='Energy sub metering'))
        lines(dat$FullDate, as.numeric(dat$Sub_metering_2), type='l', col='red')
        lines(dat$FullDate, as.numeric(dat$Sub_metering_3), type='l', col='blue')
        legend('topright', c('Sub_metering_1',
                             'Sub_metering_2',
                             'Sub_metering_3'),
               col=c('black', 'red', 'blue'),
               lty=1, lwd=2)
        dev.off()
}