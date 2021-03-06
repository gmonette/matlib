#' Matrix Power
#'
#' A simple function to demonstrate the power of a square symmetrix matrix in terms of its eigenvalues and eigenvectors.
#'
#' @param A a square symmetrix matrix
#' @param p matrix power, not necessarily a positive integer
#' @param tol tolerance for determining if the matrix is symmetric
#' @return \code{A} raised to the power \code{p}: \code{A^p}
#' @details The matrix power \code{p} can be a fraction or other non-integer.  For example, \code{p=1/2} and
#'      \code{p=1/3} give a square-root and cube-root of the matrix.
#'
#'      Negative powers are also allowed. For example, \code{p=-1} gives the inverse and \code{p=-1/2}
#'      gives the inverse square-root.
#' @seealso The \code{\link[expm]{\%^\%}} operator in the \code{expm} package is far more efficient

mpower <- function(A, p, tol=sqrt(.Machine$double.eps)) {
  if (!is.numeric(A) || !is.matrix(A) || nrow(A) != ncol(A) || any(abs(A - t(A)) > tol))
    stop("A must be a numeric, square, symmetric matrix")
  e <- eigen(A)
  M <- e$vectors   # matrix for changing basis
  d <- e$values    # eigen values
  return(M %*% diag(d^p) %*% t(M))
}

