corr <- function(directory, threshold=0) {
  res <- numeric(0)
  comp_cases <- complete(directory)
  comp_cases <- comp_cases[(comp_cases$nobs > threshold), ]
  if (nrow(comp_cases) > 0) {
    for (monitor in comp_cases$id) {
      path <- paste(getwd(), '/', directory, '/', sprintf('%03d', monitor), '.csv', sep='')
      fhand <- read.csv(path)
      good_data <- fhand[(!is.na(fhand$sulfate)), ]
      good_data <- good_data[(!is.na(good_data$nitrate)), ]
      sulfate_data <- good_data['sulfate']
      nitrate_data <- good_data['nitrate']
      res <- c(res, cor(sulfate_data, nitrate_data))
    
    }
  }
  res
}  