# === Question 1 ===
# The American Community Survey distributes downloadable data about United States communities. Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
# 
# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. 
# Assign that logical vector to the variable agricultureLogical. 
# Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE. 
# 
# What are the first 3 values that result?
  
dat <- read.csv('ss06hid.csv')
agricultureLogical <- dat$ACR == 3 & dat$AGS == 6
head(which(agricultureLogical), 3)

## Returns: [1] 125 238 262


# === Question 2 ===
# Using the jpeg package read in the following picture of your instructor into R
#   https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg 
# Use the parameter native=TRUE. 
# 
# What are the 30th and 80th quantiles of the resulting data? 
  
library(jpeg)

img <- readJPEG('jeff.jpg', native=TRUE)
quant <- quantile(img, prob=c(0.3, 0.8))

## Returns:       
# 30%       80% 
# -15259150 -10575416


# === Question 3 ===
# Load the Gross Domestic Product data for the 190 ranked countries in this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv 
# Load the educational data from this data set:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv
# Match the data based on the country shortcode. 
# 
# How many of the IDs match? Sort the data frame in descending order by GDP rank (so United States is last). 
# What is the 13th country in the resulting data frame?
  
library(data.table)
library(dplyr)

# download and have a look at GDP.csv 
gdp_dat <- data.table::fread('GDP.csv', skip=5, nrows=190, 
                             select=c(1, 2, 4, 5), 
                             col.names = c('CountryCode', 'Ranking', 'Economy', 'Total'))

ed_dat <- read.csv('EDSTATS_Country.csv')
merged_dat <- merge(gdp_dat, ed_dat, by='CountryCode')

nrow(merged_dat)  ## Returns: 189 (matches)
sorted_rank <- arrange(merged_dat, desc(Ranking))
sorted_rank$Economy[13]  ## Returns: [1] "St. Kitts and Nevis"


# === Question 4 ===
# What is the average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?  

# "Average GDP Ranking of High income: OECD" Group
high_OECD <- filter(merged_dat, Income.Group == 'High income: OECD')
mean(high_OECD$Ranking)  ## Returns: [1] 32.96667

# "Average GDP Ranking of High income: nonOECD" Group
high_nonOECD <- filter(merged_dat, Income.Group == 'High income: nonOECD')
mean(high_nonOECD$Ranking)  ## Returns: [1] 91.91304
# ------------------------------------------------------- #
# Advanced solution:
# mergedDT[`Income Group` == "High income: OECD"
#          , lapply(.SD, mean)
#          , .SDcols = c("Rank")
#          , by = "Income Group"]
#
## Returns: 
#         Income Group     Rank
# 1: High income: OECD 32.96667

# === Question 5 ===
# Cut the GDP ranking into 5 separate quantile groups. 
# Make a table versus Income.Group. 
# 
# How many countries are Lower middle income but among the 38 nations with highest GDP?

partitions <- quantile(merged_dat$Ranking, probs=seq(0, 1, 0.2), na.rm=TRUE)
merged_dat$RankingQuantile <- cut(merged_dat$Ranking, breaks=partitions)  # cut into 5 partitions

subset(merged_dat, Income.Group == 'Lower middle income') %>% count(RankingQuantile)

## Returns: 
# A tibble: 5 x 2
# RankingQuantile     n
# <fct>           <int>
# 1 (1,38.6]            5
# 2 (38.6,76.2]        13
# 3 (76.2,114]         11
# 4 (114,152]           9
# 5 (152,190]          16

