fhand <- read.csv(url('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'))
res1 <- count(fhand, fhand$VAL == 24)

# fhand$VAL == 24    n
# 1           FALSE 4367
# 2            TRUE   53
# 3              NA 2076

dat <- read.xlsx('getdata-data-DATA.gov_NGAP.xlsx', sheetIndex=1, rowIndex=18:23, colIndex=7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

# 36534720

fhand3 <- read_xml('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml')
