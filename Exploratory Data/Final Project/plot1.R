# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 1: How the total emissions from PM2.5 dereased in the US from 1999 to 2008?
# Use base plotting system to show the total emission in each year.

totalpm25 <- aggregate(Emissions~year, data=NEI, FUN=sum)
# range(totalpm25$Emissions) -> We see that the sum lies between about 3.2 million to 7.3 million
totalpm25$Emissions <- totalpm25$Emissions / 1e3 # Scale the values by a factor of thousands

png(filename='plot1.png')
barplot(totalpm25$Emissions, ylab='Total PM2.5 Emissions (thousand tons)', 
        xlab='Year', names.arg=totalpm25$year, 
        main='Total PM2.5 emissions accross the US from 1999 to 2008')

dev.off()
