# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 2: How the total emissions from PM2.5 in Baltimore City (fips='24510') dereased from 1999 to 2008?
# Use base plotting system to show the total emission in each year.

pm25_baltimore <- aggregate(Emissions~year, data=subset(NEI, fips=='24510'), FUN=sum)
pm25_baltimore$Emissions <- pm25_baltimore$Emissions / 1e3

png(filename='plot2.png')
barplot(pm25_baltimore$Emissions,
        xlab='Year',
        ylab='Total PM2.5 Emissions (thousand tons)',
        names.arg = pm25_baltimore$year,
        main='Total PM2.5 Emissions in Baltimore City from 1999 to 2008')

dev.off()
