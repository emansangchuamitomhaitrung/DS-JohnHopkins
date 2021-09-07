rankall <- function(outcome, num='best'){
        library(dplyr)

        ## Read outcome data
        outcome0 <- read.csv('outcome-of-care-measures.csv',
                             colClasses = 'character')

        ## Any outcomes do not have data on the following
        ## fields will be excluded form ranking
        if ((outcome %in% c('heart attack', 'heart failure',
                                 'pneumonia')) == FALSE) {
                stop('invalid outcome')
        }
        if (outcome == 'heart attack') {
                col <- 11
        }
        else if (outcome == 'heart failure') {
                col <- 17
        }
        else {
                col <- 23
        }
        outcome0[, col] <- as.numeric(outcome0[, col])
        outcome0 <- outcome0[!is.na(outcome0[, col]), ]
        state_split <- split(outcome0, outcome0$State)
        rank <- lapply(state_split, function(x, num) {
                x = x[order(x[, col], x$Hospital.Name), ]
                
                if (num == 'best') {
                        return (x$Hospital.Name[1])
                }
                else if (num == 'worst') {
                        return (x$Hospital.Name[nrow(x)])
                }
                else {
                        return (x$Hospital.Name[num])
                }
        }, num)
        
        ## return data.frame
        return (data.frame(hospital=unlist(rank), state=names(rank)))
        
}

## ==== Test Cases ====
## head(rankall("heart attack", 20), 10)
## Returns: 
# hospital states
# AK                                <NA>     AK
# AL      D W MCMILLAN MEMORIAL HOSPITAL     AL
# AR   ARKANSAS METHODIST MEDICAL CENTER     AR
# AZ JOHN C LINCOLN DEER VALLEY HOSPITAL     AZ
# CA               SHERMAN OAKS HOSPITAL     CA
# CO            SKY RIDGE MEDICAL CENTER     CO
# CT             MIDSTATE MEDICAL CENTER     CT
# DC                                <NA>     DC
# DE                                <NA>     DE
# FL      SOUTH FLORIDA BAPTIST HOSPITAL     FL
