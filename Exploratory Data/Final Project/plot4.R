# Getting the data
source('~/DS-JohnHopkins/Exploratory Data/Final Project/fetch-data.R')

# Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Find coal combustion-related source with regex, merged_dat is processed in 'fetch-data.R' file
coal_source <- merged_dat[grepl('coal', merged_dat$Short.Name, ignore.case = TRUE),]
coal_agg <- aggregate(Emissions~year, coal_source, FUN=sum)
coal_agg$Emissions <- coal_agg$Emissions / 1e3

png('plot4.png')
barplot(coal_agg$Emissions, ylab='Total PM2.5 Emissions (thousand tons)', 
        xlab='Year', names.arg=coal_agg$year, 
        main='Total PM2.5 Emissions coal from combustion-related sources')


dev.off()
 