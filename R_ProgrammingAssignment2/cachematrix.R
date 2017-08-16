# This function creates a special "matrix" object that can cache its inverse.
# Creates a list containing functions to set and get the matrix and its inverse

makeCacheMatrix <- function(x = matrix()) {
  inverse <- NULL  # Variable for caching
  
  # Set and get original matrix
  setMatrix <- function(y) {
    x <<- y
    inverse <<- NULL # Clean cache
  }
  getMatrix <- function() { x }
  
  # Store and get to the cache
  setInverse <- function(inv) { inverse <<- inv }
  getInverse <- function() { inverse }
  
  list(set = setMatrix, 
       get = getMatrix, 
       setinverse = setInverse, 
       getinverse = getInverse)
}


# Calculates the inverse of the special "matrix" created with the above function. 
# It first checks to see if the inverse has already been calculated and gets the result
# from the cache and skips the computation. Otherwise, it calculates 
# the inverse and sets the result in the cache.

cacheSolve <- function(x) {
  # Get the inverse of 'x'
  inverse <- x$getinverse()
  
  # Test if it is already cached
  if(!is.null(inverse)) {
    print('Cached.')
    return(inverse)
  }
  
  matrix <- x$get()
  inverse <- solve(matrix)
  # Cache the result
  x$setinverse(inverse)
  inverse
}

# Running:
# m <- matrix(1:4, nrow = 2, ncol = 2)
# cache <- makeCacheMatrix(m)
# cacheSolve(cache)
# cacheSolve(cache) # Returns cached matrix
