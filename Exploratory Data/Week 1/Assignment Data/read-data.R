# Objective: Read the household_power_consumption.txt file, 
# only extract the date from the dates 2007-02-01 and 2007-02-02.

url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

# Downloading and unzipping the data
if (!file.exists('./Assignment Data')){
        dir.create('./Assignment Data')
        download.file(url, destfile = './Assignment Data/household_power_consumption.zip')
        unzip(zipfile='./Assignment Data/household_power_consumption.zip', exdir='./Assignment Data')
        file.remove('./Assignment Data/household_power_consumption.zip')
}

# Read the data, whose dimension is 2,075,259 x 9
full_dat <- read.table('./Assignment Data/household_power_consumption.txt', sep=';', header=TRUE, stringsAsFactors = FALSE)

# Converting date & time to compatible objects in R
full_dat$Date <- as.Date(full_dat$Date, format='%d/%m/%Y')
full_dat$Time <- format(full_dat$Time, fomar='%H:%M:%S')

# Subsetting required data range
dat <- subset(full_dat, Date=='2007-02-01' | Date=='2007-02-02')  # 2880x9

# Create an additional column, namely FullDate including weekday, date and time to conveniently construct the plots
FullDate <- strptime(paste(dat$Date, dat$Time, sep=' '), format='%Y-%m-%d %H:%M:%S')
dat <- cbind(dat, FullDate)


## A glance at the data
# head(dat)
## Returns:
# Date     Time Global_active_power Global_reactive_power Voltage
# 66637 2007-02-01 00:00:00               0.326                 0.128 243.150
# 66638 2007-02-01 00:01:00               0.326                 0.130 243.320
# 66639 2007-02-01 00:02:00               0.324                 0.132 243.510
# 66640 2007-02-01 00:03:00               0.324                 0.134 243.900
# 66641 2007-02-01 00:04:00               0.322                 0.130 243.160
# 66642 2007-02-01 00:05:00               0.320                 0.126 242.290
# Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
# 66637            1.400          0.000          0.000              0
# 66638            1.400          0.000          0.000              0
# 66639            1.400          0.000          0.000              0
# 66640            1.400          0.000          0.000              0
# 66641            1.400          0.000          0.000              0
# 66642            1.400          0.000          0.000              0
# FullDate
# 66637 2007-02-01 00:00:00
# 66638 2007-02-01 00:01:00
# 66639 2007-02-01 00:02:00
# 66640 2007-02-01 00:03:00
# 66641 2007-02-01 00:04:00
# 66642 2007-02-01 00:05:00