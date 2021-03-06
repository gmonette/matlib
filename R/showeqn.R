################################
# -- Show A, b as equations
################################

#' Show Matrices (A, b) as Linear Equations
#'
#' Shows what matrices \eqn{A, b} look like as the system of linear equations, \eqn{A x = b}, but written out
#' as a set of equations.
#'
#' @param A either the matrix of coefficients of a system of linear equations, or the matrix \code{cbind(A,b)}
#' @param b if supplied, the vector of constants on the right hand side of the equations
#' @param vars a numeric or character vector of names of the variables.
#'        If supplied, the length must be equal to the number of unknowns in the equations.
#'        The default is \code{paste0("x", 1:ncol(A)}.
#' @param simplify logical; try to simplify the equations?
#' @return a one-column character matrix, one row for each equation
#' @author Michael Friendly
#' @seealso \code{\link{plotEqn}}, \code{\link{plotEqn3d}}
#' @examples
#'   A <- matrix(c(2, 1, -1,
#'                -3, -1, 2,
#'                -2,  1, 2), 3, 3, byrow=TRUE)
#'   b <- c(8, -11, -3)
#'   showEqn(A, b)
#'   # show numerically
#'   x <- solve(A, b)
#'   showEqn(A, b, vars=x)

showEqn <- function(A, b, vars, simplify=FALSE) {
  if (missing(b)) {
    b <- A[,ncol(A)]   # assume last column of Ab
    A <- A[,-ncol(A)]  # remove b from A
  }
  if (missing(vars)) vars <- paste0("x", 1:ncol(A))
  res <- character(nrow(A))
  for (i in 1:nrow(A)) {
    res[i] <- paste(A[i,], "*", vars, sep="", collapse=" + ")
    res[i] <- paste(res[i], " = ", b[i])
  }
  res <- gsub("+ -", "- ", res, fixed=TRUE)  # map "+ -3" -> "-3"
  if (simplify) {
    res <- gsub("1*", "", res, fixed=TRUE)    # "1*x" -> "x"
    V <- substr(vars[1], 1,1)
    pat <- gsub("x", V, "0\\*x\\d\\s+[+-]|[+-]\\s+0\\*x\\d")
    res <- gsub(pat, "", res)   # "+ 0*x" -> ""
    res <- gsub("  ", " ", res, fixed=TRUE)
  }
  matrix(res, ncol=1)
}


