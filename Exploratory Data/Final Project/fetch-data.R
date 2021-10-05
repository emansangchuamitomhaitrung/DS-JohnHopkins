# Download and prepare the data
url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
if (!file.exists('./Project-Data')){
        dir.create('./Project-Data')
        download.file(url, destfile = './Project-Data/NEI-data.zip')
        unzip(zipfile='./Project-Data/NEI-data.zip', exdir='./Project-Data')
        # Reading the data with these two lines of code (Gonna take a while)
        NEI <- readRDS('./Project-Data/summarySCC_PM25.rds')
        SCC <- readRDS('./Project-Data/Source_Classification_Code.rds')
}

# Reading the data with these two snippets of code (Gonna take a while)
if (!exists('NEI')){
        NEI <- readRDS('./Project-Data/summarySCC_PM25.rds')
}
if (!exists('SCC')){
        SCC <- readRDS('./Project-Data/Source_Classification_Code.rds')
}

# Create a merged data, where SCC variable in NEI is mapped to its corrsponding value in SCC database
if (!exists('merged_dat')){
        merged_dat <- merge(NEI, SCC, by='SCC')
}
