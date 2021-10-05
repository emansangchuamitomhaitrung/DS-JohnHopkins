# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City?
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)


baltimore_dat <- aggregate(Emissions ~ year+type, subset(NEI, fips=='24510'), FUN=sum)
baltimore_dat$Emissions <- baltimore_dat$Emissions / 1e3

png(filename='plot3.png')
g <- ggplot(baltimore_dat, aes(year, Emissions, color=type)) +
        geom_line() +
        ylab('Total PM2.5 Emissions (thousand tons)') +
        xlab('Year') +
        ggtitle('Total PM2.5 Emissions in Baltimore from 1999 to 2008')
print(g)

dev.off()
                    
