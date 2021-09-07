rankhospital <- function(state, outcome, num='best') {
        ## Read outcome data
        outcome0 <- read.csv('outcome-of-care-measures.csv',
                             colClasses = 'character')
        ## Validate state
        if (!any(state == outcome0$State)) {
                stop('invalid state')
        }
        ## Any outcomes do not have data on the following
        ## fields will be excluded form ranking
        else if ((outcome %in% c('heart attack', 'heart failure',
                                 'pneumonia')) == FALSE) {
                stop('invalid outcome')
        }
        outcome1 <- subset(outcome0, State == state)
        if (outcome == 'heart attack') {
                col <- 11
        }
        else if (outcome == 'heart failure') {
                col <- 17
        }
        else {
                col <- 23
        }
        outcome1[, col] <- as.numeric(outcome1[, col])
        ## sort the outcome1 and remove NAs
        sort_outcome <- outcome1[order(outcome1[, col], outcome1[, 2]), ]  # best to worst and by lexico
        sort_outcome <- sort_outcome[(!is.na(sort_outcome[, col])), ]
        
        ## extract the result
        if (num == 'best'){
                return (sort_outcome[1, 2])
        }
        else if (num == 'worst'){
                return(sort_outcome[nrow(sort_outcome), 2])
        }
        else {
                return (sort_outcome[num, 2])
        }
}


## ===== Test Cases =====
## rankhospital("TX", "heart failure", 4)
## Returns: "DETAR HOSPITAL NAVARRO"
##
## rankhospital("MD", "heart attack", "worst")
## Returns: "HARFORD MEMORIAL HOSPITAL"
## 
## rankhospital("MN", "heart attack", 5000)
## Returns: NA

        
