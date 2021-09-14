=== Question 1 ===
# Register an application with the Github API here https://github.com/settings/applications. 
# Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
# Use this data to find the time that the datasharing repo was created. 
# 
# What time was it created?
#   
# This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). You may also need to run the code in the base R package and not R studio.

# install.packages('httpuv')
# install.packages('httr')
# install.packages('jsonlite')
library(httr)
library(jsonlite)  


# 1. Find OAuth settings for github:
#    http://developer.github.com/v3/oauth/
oauth_endpoints("github")

# 2. To make your own application, register at
#    https://github.com/settings/developers. Use any URL for the homepage URL
#    (http://github.com is fine) and  http://localhost:1410 as the callback url
#
#    Replace your key and secret below.
myapp <- oauth_app("your_app_name",
                   key = "your_client_id",
                   secret = "your_client_secret"
)

# 3. Get OAuth credentials
github_token <- oauth2.0_token(oauth_endpoints("github"), myapp)

# 4. Use API
gtoken <- config(token = github_token)
req <- GET("https://api.github.com/users/jtleek/repos", gtoken)
stop_for_status(req)
content <- content(req)

dat <- fromJSON(toJSON(content))  # convert to json format and to data frame
dat[dat$name == 'datasharing',]$created_at  # find the creation time of repo 'datasharing'

## Returns: [1] "2013-11-07T13:25:07Z"


=== Question 2 ===
# The sqldf package allows for execution of SQL commands on R data frames. 
# We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. 
# 
# Download the American Community Survey data and load it into an R object called acs
#   https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv
# 
# Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?

# install.packages('sqldf')
library(sqldf)
library(data.table)

url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
path <- file.path(getwd(), 'ss06pid.csv')
download.file(url, path)
acs <- data.table(read.csv(path))

res <- res <- sqldf('select pwgtp1 from acs where AGEP<50')
head(res)

## Returns:   pwgtp1
# 1     87
# 2     88
# 3     94
# 4     91
# 5    539
# 6    192

=== Question 3 ===
# Using the same data frame you created in the previous problem. 
# 
# What is the equivalent function to unique(acs$AGEP)


res2 <- sqldf("select distinct pwgtp1 from acs")
head(res2)

## Returns:   
#   pwgtp1
# 1     87
# 2     88
# 3     94
# 4     91
# 5    539
# 6    192

=== Question 4 === 
# How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page:
#   
#   http://biostat.jhsph.edu/~jleek/contact.html
# 
# (Hint: the nchar() function in R may be helpful)

url <- 'http://biostat.jhsph.edu/~jleek/contact.html'
htmlCode <- readLines(url)
close(url)

c(nchar(htmlCode[10]), nchar(htmCode[20]), nchar(htmlCode[30]), nchar(htmlCode[100]))

## Returns: 45 31 7 25

=== Question 5 ===
# Read this data set into R and report the sum of the numbers in the fourth of the nine columns.
# 
# https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for
# 
# Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for
# 
# (Hint this is a fixed width file format) -> Use function read.fwf() /fwf := fixed width file/
# Protocol: https://github.com/lgreski/datasciencectacontent/blob/master/markdown/cleaningData-week2Q5.md
  
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for"
theColumns <- c("week", "nino1and2sst", "nino1and2ssta", "nino3sst", 
                "nino3ssta", "nino34sst", "nino34ssta", "nino4sst", "nino4ssta")
# Name 9 columns for the dataset
w <- c(-1,9,-5,4,4,-5,4,4,-5,4,4,-5,4,4)
# Open the linked file in any text editor, the first column is indented by 1 space, thus -1,
# 9 is the length of the date i.e. '03JAN1990',
# -5 is the space between 'Week' column and the next column, the process keeps going until we get the width-vector as above.

dat2 <- read.fwf(url, w, skip=4, col.names=theColumns)
sum(dat2[, 4])

## Returns: [1] 32426.7
