# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Extract data related to motor vehicle emissions
baltimore_emission <- subset(merged_dat, fips=='24510')
motor_sources <- baltimore_emission[grepl('vehicles', baltimore_emission$EI.Sector, ignore.case = TRUE),]

motor_agg <- aggregate(Emissions~year, motor_sources, FUN=sum)
motor_agg$Emissions <- motor_agg$Emissions / 1e3

png('plot5.png', width=600)
barplot(motor_agg$Emissions, ylab='Total PM2.5 Emissions (thousand tons)', 
        xlab='Year', names.arg=motor_agg$year, 
        main='Total PM2.5 Emissions from motor vehicle sources in Baltimore City')

dev.off()
