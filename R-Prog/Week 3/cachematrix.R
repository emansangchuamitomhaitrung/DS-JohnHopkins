## makeCacheMatrix create a list of functions that do the following:
## set/get the value of the matrix
## set/get the value of the inverse matrix

makeCacheMatrix <- function(X = matrix()) {
        inv <- NULL
        set <- function(Y) {
                X <<- Y
                inv <<- NULL
        }
        get <- function() X
        
        set_inverse <- function(inverse) inv <<- solve
        get_inverse <- function() inv
        list(set=set, get=get,
             set_inverse=set_inverse,
             get_inverse=get_inverse)
        
}


## Calculate the inverse of the given matrix
## If the inverse has already been calculated,
## the cacheSolve function will return the result from cache

cacheSolve <- function(X, ...) {
        inv <- X$get_inverse()
        if (!is.null(inv)) {
                message('getting cached data')
                return (inv)
        }
        result <- X$get()
        inv <- solve(result, ...)
        X$set_inverse(inv)
        inv
}


## Test Case:

## a <- makeCacheMatrix(matrix(c(4, 3, 3, 2), 2, 2))
## a$get()
##
## [,1] [,2]
## [1,]    4    3
## [2,]    3    2
##
## cacheSolve(a)
##
## [,1] [,2]
## [1,]   -2    3
## [2,]    3   -4


