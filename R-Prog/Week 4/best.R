best <- function(state, outcome) {
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
        ## Find the best hospital in state
        min <- which(as.numeric(outcome1[, col]) == 
                             min(as.numeric(outcome1[, col]),
                                 na.rm=TRUE))
        hospital <- outcome1[min, 2]  # col2 == name of hospital
        hospital <- sort(hospital)  # sort hospitals by lexico
        hospital[1]  # return the best hospital
}
                
## Test Cases:
## best('TX', 'heart attack')
## Returns: "CYPRESS FAIRBANKS MEDICAL CENTER"
## 
## best('BB', 'heart attack')
## Returns: Error in best("BB", "heart attack") : invalid state


