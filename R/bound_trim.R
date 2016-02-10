#' Bound trim the sequence vector
#'
#' 일반수열에서 최소치와 최대치를 넘어가는, 일종의 경계선을 넘겨버린 값 만을 제외시킨 결과를 반환합니다.
#' @param vector 대상이되는 sequence를 입력합니다. e.g \code{1:100}
#' @param min 최소경계를 지정합니다. e.g \code{5}
#' @param max 최대경계를 지정합니다. e.g \code{95}
#' @export
#' @examples
#' bound_trim(1:100, 5, 95)
#' bound_trim(c(1, 5, 9, 10), 0, 9)
#' bound_trim(rnorm(100), -1.96, 1.96)
bound_trim <- function(vector, min, max){
  index <- vector>=min&vector<=max
  res <- vector[index]
  return(res)
}

#' Bandwidth indexing with Bound trim
#'
#' Bandwidth indexing with Bound trim
#' @param W0 Bandwidth 크기를 설정합니다.
#' @param c Bandwidth indexing 의 기준점을 설정합니다.
#' @param min 최소경계를 지정합니다.
#' @param max 최대경계를 지정합니다.
#' @export
#' @examples
#' window(10, 0, -20, 20)
#' window(10, 0, -5, 20)
window <- function(W0, c, min, max){
  return(bound_trim((c-W0):(c+W0), min, max))
}
