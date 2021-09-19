# Reading data
source('~/DS-JohnHopkins/Exploratory Data/Week 1/Assignment Data/read-data.R')

# Plotting using base plotting system and save to a PNG file of 480x480 (pixels)
# Fourth plot: Consisting of 4 plots:
# - Line graph of Global Active Power
# - Line graph of Voltage value
# - Line graphs of Energy sub metering of three sub meterings
# - Line graph of Global Reactive Power
plot4 <- function(dat) {
        png('./Assignment Data/plot4.png', width=480, height=480)
        par(mfrow=c(2, 2))
        with(dat, plot(FullDate, as.numeric(Global_active_power), type='l', 
                        xlab='', ylab='Global Active Power'))
        with(dat, plot(FullDate, as.numeric(Voltage), type='l',
                        xlab='datetime', ylab='Voltage'))
        with(dat, plot(FullDate, Sub_metering_1, type='l',
                        xlab='', ylab='Energy sub metering'))
                lines(dat$FullDate, dat$Sub_metering_2, type='l', col='red')
                lines(dat$FullDate, dat$Sub_metering_3, type='l', col='blue')
                legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
                       col=c('black', 'red', 'blue'),
                       lty=1, lwd=2, bty='n')
        with(dat, plot(FullDate, as.numeric(Global_reactive_power), type='l',
                        xlab='datetime', ylab='Global_reactive_power'))
        
        dev.off()
}