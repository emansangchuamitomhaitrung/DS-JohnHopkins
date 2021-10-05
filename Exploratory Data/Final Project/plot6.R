# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 6: Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angeles County, California (fips=='06037)
# Which city has seen greater changes over time

library(ggplot2)
# Extract data related to motor vehicle emissions in LA and Baltimore
baltiLA<- subset(merged_dat, fips=='24510' | fips=='06037')
motor_sources_baltiLA <- baltiLA[grepl('vehicles', baltiLA$EI.Sector, ignore.case = TRUE),]

baltiLA_agg <- aggregate(Emissions~year+fips, motor_sources_baltiLA, sum)
baltiLA_agg$fips[baltiLA_agg$fips == '24510'] <- 'Baltimore City'
baltiLA_agg$fips[baltiLA_agg$fips == '06037'] <- 'Los Angeles County'
baltiLA_agg$Emissions <- baltiLA_agg$Emissions / 1e3

png('plot6.png', width=680)
g <- ggplot(baltiLA_agg, aes(factor(year), Emissions))
g <- g + facet_grid(.~fips)
g <- g + geom_bar(stat='identity') +
        xlab('Year') + ylab('Total PM2.5 Emissions (thousand tons)') +
        ggtitle('Total PM2.5 Emissions from motor vehicles in Baltimore and LA from 1999 to 2008')
print(g)

dev.off()