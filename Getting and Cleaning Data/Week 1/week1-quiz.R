## == Question 1 ==
# The American Community Survey distributes downloadable data about United States communities. 
# Download the 2006 microdata survey about housing for the state of Idaho using download.file() from here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv
# and load the data into R. The code book, describing the variable names is here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf 
#
# How many properties are worth $1,000,000 or more?
# ========================================================================================================== #

fhand <- read.csv(url('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'))
res1 <- count(fhand, fhand$VAL == 24)

## Returns:
# fhand$VAL == 24    n
# 1           FALSE 4367
# 2            TRUE   53
# 3              NA 2076


## == Question 3 ==
# Download the Excel spreadsheet on Natural Gas Aquisition Program here: 
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx 
# Read rows 18-23 and columns 7-15 into R and assign the result to a variable called 'dat'
#
# What is the value of: sum(dat$Zip*dat$Ext,na.rm=T)
# ========================================================================================================== #

dat <- read.xlsx('getdata-data-DATA.gov_NGAP.xlsx', sheetIndex=1, rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

## Returns: 36534720

# == Question 4 == 
# Read the XML data on Baltimore restaurants from here:
# https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml 
# How many restaurants have zipcode 21231? 
# ========================================================================================================== #

library(XML)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
dat <- xmlTreeParse(url, useInternal = TRUE)  # Load data
rootNode <- xmlRoot(data)  # Wrapper element
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231") 

## Returns: 127
