pollutantmean <- function(directory, pollutant, id=1:332) {
  mean_data <- c()
  for (monitor in id) {
      path <- paste(getwd(), '/', directory, '/', sprintf('%03d', monitor), '.csv', sep='')
      fhand <- read.csv(path)
      good_data <- fhand[pollutant]
      mean_data <- c(mean_data, good_data[!is.na(good_data)])
  }
  mean(mean_data)
}     
              

