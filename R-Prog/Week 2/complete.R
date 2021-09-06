complete <- function(directory, id=1:332) {
  res <- data.frame(id=numeric(0), nobs=numeric(0))
  for (monitor in id) {
    path <- paste(getwd(), '/', directory, '/', sprintf('%03d', monitor), '.csv', sep='')
    fhand <- read.csv(path)
    good_data <- fhand[(!is.na(fhand$sulfate)), ]
    good_data <- good_data[(!is.na(good_data$nitrate)), ]
    nobs <- nrow(good_data)
    res <- rbind(res, data.frame(id=monitor, nobs=nobs))
  }
  res  
}