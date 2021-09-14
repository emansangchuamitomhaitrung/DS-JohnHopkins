# === Question 1 ===
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf
# Apply strsplit() to split all the names of the data frame on the characters "wgtp". 
# 
# What is the value of the 123 element of the resulting list?
  
dat <- read.csv('ss06hid.csv')
strsplit(names(dat), '\\wgtp')[123]

## Returns: [1] ""   "15"


# === Question 2 ===
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv
# Remove the commas from the GDP numbers in millions of dollars and average them. 
# 
# What is the average?
  
gdp_dat <- data.table::fread('GDP.csv', skip=5, nrows=190, 
                             select=c(1, 2, 4, 5), 
                             col.names = c('CountryCode', 'Ranking', 'Economy', 'Total'))
mean(as.numeric(gsub(',', '', gdp_dat$Total)))

## Returns: [1] 377652.4


# === Question 4 ===
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. 
# 
# Of the countries for which the end of the fiscal year is available, how many end in June?

ed_dat <- read.csv('EDSTATS_Country.csv')
merged_dat <- merge(gdp_dat, ed_dat, by='CountryCode')
nrow(subset(merged_dat, grepl('Fiscal year end: June', Special.Notes)))

## Returns: [1] 13


# === Question 5 ===
# You can use the quantmod (http://www.quantmod.com/) package to get historical stock prices for publicly traded companies on the NASDAQ and NYSE.
# 
# How many values were collected in 2012? How many values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)
time_dat <- data.table(sampleTimes)

nrow(subset(time_dat, grepl('^2012-', sampleTimes)))  # Returns: [1] 250
nrow(subset(time_dat, grepl('^2012-', sampleTimes) & wday(time_dat$sampleTimes) == 2))  # Returns: [1] 47
 
