#' Shrinkage operator function
#'
#' Shrinkage operator function
#' @export

Shrinkage_operator <- function(tau, x) sign(x) * pmax(abs(x) - tau, 0)

#' Singular value thresholding operator function
#'
#' Singular value thresholding operator function
#' @details 본 함수는 \code{Shrinkage.operator}, \code{corpcor::fast.svd()} 함수를 이용합니다.
#' 따라서 corpcor package 종속입니다.
#' @seealso \link{fast.svd}
#' @export

Singular_value_thresholding_operator <- function(tau, x){

  stopifnot(require(corpcor))

  svd.x <- fast.svd(x)
  U <- svd.x$u
  D <- diag(svd.x$d)
  V <- svd.x$v
  res <- U %*% Shrinkage_operator(tau, D) %*% t(V)

  return(res)

}
