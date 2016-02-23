#' Outlier detect
#'
#' Outlier detect
#'
#' @param x numeric vector 을 입력합니다.
#' @export
#' @examples
#' set.seed(111)
#' r <- rnorm(100)
#' outlier_detect(r)
#' r[which(outlier_detect(r))]
#' boxplot(r)$out
outlier_detect <- function(x){
  bottom <- quantile(x, 0.25)-IQR(x)*1.5
  top <- quantile(x, 0.75)+IQR(x)*1.5
  return(x<=bottom | x>=top)
}

